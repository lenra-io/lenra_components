import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fr_lenra_client/apps/lenra_app_data_provider.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_checkbox.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_textfield.dart';
import 'package:fr_lenra_client/lenra_components/container/lenra_container.dart';
import 'package:fr_lenra_client/lenra_components/container/lenra_scroll_view.dart';
import 'package:fr_lenra_client/lenra_components/lenra_image.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text.dart';
import 'package:fr_lenra_client/error/component/component_error.dart';
import 'package:fr_lenra_client/socket/ui_patch_event.dart';
import 'package:fr_lenra_client/socket/ui_stream_controller.dart';

class LenraComponent<T extends LenraComponentState> extends StatefulWidget {
  //? This map define the how to create State of each Lenra UIComponents types
  static final Map<String, dynamic> _classLists = {
    'container': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraContainerState(
            properties: root, styles: styles, parent: parent, id: id),
    'scroll-view': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraScrollViewState(
            properties: root, styles: styles, parent: parent, id: id),
    'text': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraTextState(
            properties: root, styles: styles, parent: parent, id: id),
    'textfield': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraTextfieldState(
            properties: root, styles: styles, parent: parent, id: id),
    'button': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraButtonState(
            properties: root, styles: styles, parent: parent, id: id),
    'checkbox': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraCheckboxState(
            properties: root, styles: styles, parent: parent, id: id),
    'image': (Map<String, dynamic> root,
            {Map<String, dynamic> styles,
            LenraComponentState parent,
            String id}) =>
        LenraImageState(
            properties: root, styles: styles, parent: parent, id: id)
  };

  LenraComponent({key, this.id, this.parent, this.styles, this.properties})
      : super(key: key);

  //? This is the Json representation of the Lenra UIComponent
  final Map<String, dynamic> properties;
  final Map<String, dynamic> styles;

  final String id;
  //? This is not final because I can't use JSON deserialize and set the parent at same time
  final LenraComponentState parent;

  factory LenraComponent.create(Map<String, dynamic> root,
      {Map<String, dynamic> styles, LenraComponentState parent, String id}) {
    // Split root and styles from current json object.
    if (root.containsKey('root')) {
      if (root.containsKey('styles')) {
        styles = root['styles'];
      }
      root = root['root'];
    }

    // Add an ID to the element to identify it later (UIStream will use it)
    if (id == null) {
      id = '/root';
    }

    // Create the component using the type in the map LenraComponent._classLists
    if (root.containsKey('type')) {
      if (LenraComponent._classLists.containsKey(root['type'])) {
        return LenraComponent(
          properties: root,
          styles: styles,
          parent: parent,
          id: id,
          key: UniqueKey(),
        );
      } else {
        throw LenraJsonMalformedError('Unknown type `${root['type']}`');
      }
    } else {
      throw LenraJsonMalformedError(
          'You need to specify a `type` key in the component definition.');
    }
  }

  static Map<String, dynamic> includeStyleIntoRoot(
      Map<String, dynamic> root, Map<String, dynamic> styles) {
    if (root['styles'] == null) {
      return root;
    }

    // styles can contain String name of stylesheet or directly styles
    // TODO: Change stylesheet by using flutter Theme() widget
    List<Map<String, dynamic>> styleList = root['styles'];
    styleList.forEach((element) {
      Map<String, dynamic> style = styles[element];
      style.forEach((key, value) {
        root[key] = value;
      });
    });

    return root;
  }

  @override
  State<StatefulWidget> createState() {
    return LenraComponent._classLists[properties['type'] as String](properties,
        styles: styles, parent: parent, id: id);
  }
}

abstract class LenraComponentState<T> extends State<LenraComponent> {
  Key key;
  String id;
  LenraComponentState parent;
  Map<String, dynamic> properties;
  Map<String, dynamic> styles;
  Stream<UiPatchEvent> stream;
  UIStreamController uiStreamController;

  LenraComponentState({
    this.id,
    this.parent,
    this.properties,
    this.styles,
    this.stream,
  }) : super();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      this.uiStreamController =
          LenraAppDataProvider.of(this.context).uiStreamController;
      this.stream = this.uiStreamController.createComponentStream(this.id);
      this.stream.listen(this.updateWidgetHandler);
    });
  }

  @override
  Widget build(BuildContext context);

  void replaceOperation(UiPatchEvent event) {
    // replace only if the properties was not the same as know by the client
    if (this.properties[event.property] != event.value) {
      addOperation(event);
    }
  }

  void addOperation(UiPatchEvent event) {
    setState(() {
      this.properties[event.property] = event.value;
    });
  }

  void removeOperation(UiPatchEvent event) {
    setState(() {
      this.properties[event.property] = null;
    });
  }

  void addChildOperation(UiPatchEvent event) {
    throw Exception(
        "addChildOperation : The component ${this.runtimeType} does not have any child. Should Be override by containers.");
  }

  void removeChildOperation(UiPatchEvent event) {
    throw Exception(
        "removeChildOperation : The component ${this.runtimeType} does not have any child. Should Be override by containers.");
  }

  void replaceChildOperation(UiPatchEvent event) {
    throw Exception(
        "replaceChildOperation : The component ${this.runtimeType} does not have any child. Should Be override by containers.");
  }

  void replaceChildTypeOperation(UiPatchEvent event) {
    throw Exception(
        "replaceChildTypeOperation : The component ${this.runtimeType} does not have any child. Should Be override by containers.");
  }

  void updateWidgetHandler(UiPatchEvent event) {
    switch (event.operation) {
      case UILenraOperation.replace:
        this.replaceOperation(event);
        break;
      case UILenraOperation.add:
        this.addOperation(event);
        break;
      case UILenraOperation.remove:
        this.removeOperation(event);
        break;
      case UILenraOperation.addChild:
        this.addChildOperation(event);
        break;
      case UILenraOperation.removeChild:
        this.removeChildOperation(event);
        break;
      case UILenraOperation.replaceChild:
        this.replaceChildOperation(event);
        break;
      case UILenraOperation.replaceChildType:
        this.replaceChildTypeOperation(event);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    uiStreamController.remove(this.id);
  }
}
