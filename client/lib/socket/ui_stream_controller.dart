import 'dart:async';
import 'dart:developer';

import 'package:fr_lenra_client/lenra_components/lenra_component.dart';
import 'package:fr_lenra_client/socket/lenra_socket.dart';
import 'package:fr_lenra_client/socket/lerna_channel.dart';
import 'package:fr_lenra_client/socket/ui_patch_event.dart';

/// UIStream permet de dispatcher les évènements de modification de l'UI aux différents éléments Lenra.
class UIStreamController {
  // Abstraction d'un Channel WebSocket
  LenraChannel chan;

  // ignore: close_sinks
  StreamController<LenraComponent> _uiStreamController;

  //? Une Map des streams liés aux éléments par leurs IDs.
  Map<String, StreamController<dynamic>> _uiStreams = Map();

  UIStreamController(String appName) {
    this.chan = LenraSocket.instance.channel("app", {"app": appName});
    this._createUiStream();
    this._createPatchUiStream();
  }

  Stream<LenraComponent> get uiStream {
    return _uiStreamController.stream;
  }

  void _handleNewUi(Map<String, dynamic> ui, EventSink<LenraComponent> sink) {
    LenraComponent component = LenraComponent.create(ui);
    sink.add(component);
  }

  void _transformPatch(
      Map<String, dynamic> patch, EventSink<UiPatchEvent> sink) {
    UILenraOperation operation =
        (patch['op'] as String).toLenraUiPatchOperation();

    dynamic value = patch['value'];
    int childIndex = -1;

    List<String> pathList = patch['path'].split('/');
    // Remove last element of path because it's the field. Id doesn\'t contain the field.
    String id = patch['path'].substring(0, patch['path'].lastIndexOf('/'));

    String last = pathList.last;

    // 4 possibilities here :
    // 1 - End with any component property except "type" => Send the event to the component.
    // 2 - End with "type" property => We have to send the event to the parent to change the component instance.
    // 3 - End with "children" => We have to send the event to the component to add/remove the children
    // 4 - End with a number => We have to send the event to the parent to add/replace/remove the child
    bool endWithChildren = last == "children";
    bool endWithType = last == "type";
    bool endWithNumber = last.isInteger();

    if (endWithType) {
      operation = UILenraOperation.replaceChildType;
      childIndex = int.parse(pathList[pathList.length - 2]);
      id = pathList.sublist(0, pathList.length - 3).join('/');
    }

    if (endWithNumber) {
      operation = operation.toChildOperation();
      childIndex = int.parse(last);
      id = pathList.sublist(0, pathList.length - 2).join('/');
    }

    if (endWithChildren) {
      // operation = operation.toChildOperation();
      id = pathList.sublist(0, pathList.length - 1).join('/');
    }

    sink.add(UiPatchEvent(id, operation, last, value, childIndex));
  }

  void _splitPatches(
      Map<String, dynamic> patchesData, EventSink<Map<String, dynamic>> sink) {
    Iterable patches = patchesData["patch"];
    if (patches is Iterable) {
      // patches exemple : [{op: replace, path: /root/children/5/children/4/value, value: 1}]
      patches.forEach((patch) {
        sink.add(patch);
      });
    } else {
      log('Data is not Iterable ${patches.toString()}');
    }
  }

  void _createPatchUiStream() {
    this
        .chan
        .getStreamController('patchUi')
        .stream
        .transform(
          StreamTransformer.fromHandlers(handleData: this._splitPatches),
        )
        .transform(
          StreamTransformer.fromHandlers(handleData: this._transformPatch),
        )
        .listen(
          (UiPatchEvent event) => this._uiStreams[event.id].add(event),
        );
  }

  void _createUiStream() {
    _uiStreamController = StreamController();

    Stream<LenraComponent> transformedUiStream =
        this.chan.getStreamController('ui').stream.transform(
              StreamTransformer.fromHandlers(handleData: this._handleNewUi),
            );

    _uiStreamController.addStream(transformedUiStream);
  }

  void send(dynamic data) {
    this.chan.send('run', data);
  }

  void close() {
    this._uiStreamController.close();
    this.chan.close();
    this._uiStreams.forEach((String key, StreamController streamController) {
      streamController.close();
    });
  }

  Stream<UiPatchEvent> createComponentStream(String componentId) {
    // ignore: close_sinks
    StreamController<UiPatchEvent> controller = StreamController();
    this._uiStreams[componentId] = controller;
    return controller.stream;
  }

  void remove(String id) {
    // TODO : Vérifier que le stream est empty avant de supprimer. Cas limite de modification de type.
    this._uiStreams.remove(id).sink.close();
  }
}
