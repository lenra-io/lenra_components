import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fr_lenra_client/apps/lenra_app_data_provider.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_checkbox.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_textfield.dart';
import 'package:fr_lenra_client/lenra_components/container/lenra_container.dart';
import 'package:fr_lenra_client/lenra_components/lenra_image.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text.dart';
import 'package:fr_lenra_client/lenra_components/props_parser.dart';
import 'package:fr_lenra_client/socket/ui_patch_event.dart';
import 'package:fr_lenra_client/socket/ui_stream_controller.dart';

// TODO : Generate this (?)
extension LenraComponentWrapperExt on LenraComponentWrapper {
  static final Map<String, Map> componentsMapping = {
    'container': {
      "propsTypes": LenraContainerExt.propsTypes,
      "constructor": LenraContainerExt.create
    },
    'text': {"propsTypes": LenraTextExt.propsTypes, "constructor": LenraTextExt.create},
    'textfield': {
      "propsTypes": LenraTextfieldExt.propsTypes,
      "constructor": LenraTextfieldExt.create
    },
    'button': {"propsTypes": LenraButtonExt.propsTypes, "constructor": LenraButtonExt.create},
    'checkbox': {"propsTypes": LenraCheckboxExt.propsTypes, "constructor": LenraCheckboxExt.create},
    'image': {"propsTypes": LenraImageExt.propsTypes, "constructor": LenraImageExt.create}
  };
}

class LenraComponentWrapper extends StatefulWidget {
  LenraComponentWrapper({Key key, this.id, this.properties}) : super(key: key);

  //? This is the Json representation of the Lenra UIComponent
  final Map<String, dynamic> properties;

  final String id;

  factory LenraComponentWrapper.create(Map<String, dynamic> props, String id) {
    // Create the component using the type in the map LenraComponent._classLists
    if (LenraComponentWrapperExt.componentsMapping.containsKey(props['type'])) {
      return LenraComponentWrapper(
        properties: props,
        id: id,
        key: UniqueKey(),
      );
    } else {
      throw 'No component with type `${props['type']}`';
    }
  }

  @override
  State<StatefulWidget> createState() {
    return LenraComponentWrapperState(properties: properties, id: id);
  }
}

class LenraComponentWrapperState extends State<LenraComponentWrapper> {
  String id;
  Map<String, dynamic> properties;
  Stream<UiPatchEvent> stream;
  UIStreamController uiStreamController;
  List<LenraComponentWrapper> children;

  LenraComponentWrapperState({
    this.id,
    this.properties,
  });

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      this.uiStreamController = LenraAppDataProvider.of(this.context).uiStreamController;
      this.stream = this.uiStreamController.createComponentStream(this.id);
      this.stream.listen(this.updateWidgetHandler);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map componentsInfo =
        LenraComponentWrapperExt.componentsMapping[this.properties['type'] as String];

    Map<Symbol, dynamic> transformedProps =
        Parser.parseProps(this.properties, componentsInfo["propsTypes"], this);

    if (transformedProps.containsKey("children")) {
      this.children = transformedProps["children"];
    }
    return Function.apply(componentsInfo["constructor"], [], transformedProps);
  }

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

  static LenraComponentWrapper createChild(
      int index, Map<String, dynamic> childProperties, LenraComponentWrapperState parentState) {
    return LenraComponentWrapper.create(childProperties, '${parentState.id}/children/$index');
  }

  void _addChild(int childIndex, Map<String, dynamic> properties) {
    this.properties['children'].insert(childIndex, properties);
    this.children.insert(
          childIndex,
          LenraComponentWrapperState.createChild(childIndex, properties, this),
        );
  }

  void _removeChild(int childIndex) {
    this.children.removeAt(childIndex);
    this.properties['children'].removeAt(childIndex);
  }

  void replaceChildTypeOperation(UiPatchEvent event) {
    setState(() {
      Map<String, dynamic> childProperties = this.children[event.childIndex].properties;
      childProperties[event.property] = event.value;

      this._removeChild(event.childIndex);
      this._addChild(event.childIndex, childProperties);
    });
  }

  void replaceChildOperation(UiPatchEvent event) {
    setState(() {
      this._removeChild(event.childIndex);
      this._addChild(event.childIndex, event.value);
    });
  }

  void addChildOperation(UiPatchEvent event) {
    setState(() {
      this._addChild(event.childIndex, event.value);
    });
  }

  void removeChildOperation(UiPatchEvent event) {
    setState(() {
      this._removeChild(event.childIndex);
    });
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
