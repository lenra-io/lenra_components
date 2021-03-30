import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_wrapper.dart';
import 'package:fr_lenra_client/lenra_application/ui_patch.dart';
import 'package:fr_lenra_client/lenra_application/update_props_event.dart';

class LenraUiBuilder extends StatefulWidget {
  final StreamController<Map<String, dynamic>> uiStream;
  final StreamController<Iterable<UiPatchEvent>> patchUiStream;

  LenraUiBuilder({this.uiStream, this.patchUiStream}) : super();

  @override
  State<StatefulWidget> createState() {
    return LenraUiBuilderState();
  }
}

class LenraUiBuilderState extends State<LenraUiBuilder> {
  final Map<String, Widget> wrappers = {};
  final Map<String, Map<String, dynamic>> componentsProperties = {};
  final StreamController<UpdatePropsEvent> updateWidgetStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    widget.uiStream.stream.listen(this.replaceUi);
    widget.patchUiStream.stream.listen(this.patchUi);
  }

  @override
  void dispose() {
    updateWidgetStream.close();
    super.dispose();
  }

  void replaceUi(Map<String, dynamic> ui) {
    setState(() {
      this.registerComponent(ui["root"] as Map<String, dynamic>, "/root");
    });
  }

  void createWrapper(String id, Map<String, dynamic> properties) {
    LenraWrapper wrapper = LenraWrapper(
      id,
      this,
      properties,
      key: ValueKey(id),
    );
    wrappers[id] = wrapper;
  }

  void registerComponent(Map<String, dynamic> properties, String path) {
    if (properties.containsKey("children")) {
      List<String> newChildrenProps = this.registerChildren(properties["children"] as List, path);
      properties["children"] = newChildrenProps;
    }
    this.registerProperties(path, properties);
    this.createWrapper(path, properties);
  }

  List<String> registerChildren(List children, String path) {
    int idx = 0;
    return children.map((dynamic child) {
      String id = "$path/children/$idx";
      this.registerComponent(child as Map<String, dynamic>, id);
      idx++;
      return id;
    }).toList();
  }

  void registerProperties(String id, Map<String, dynamic> properties) {
    componentsProperties[id] = properties;
  }

  void replaceOperation(UiPatchEvent patch) {
    this.addOperation(patch);
  }

  void addOperation(UiPatchEvent patch) {
    if (patch.propertyPathList.last == "children") {
      List<String> newChildrenProps = this.registerChildren(patch.value as List, patch.id);
      this.setProperty(
        this.componentsProperties[patch.id],
        patch.propertyPathList,
        newChildrenProps,
      );
    } else {
      this.setProperty(
        this.componentsProperties[patch.id],
        patch.propertyPathList,
        patch.value,
      );
    }
  }

  void removeOperation(UiPatchEvent patch) {
    this.removeProperty(this.componentsProperties[patch.id], patch.propertyPathList);
  }

  void removeProperty(Map<String, dynamic> properties, List<String> propertyPathList) {
    Map<String, dynamic> current = properties;
    for (int i = 0; i < propertyPathList.length - 1; i++) {
      current = current[propertyPathList[i]];
    }
    current.remove(propertyPathList.last);
  }

  void setProperty(Map<String, dynamic> properties, List<String> propertyPathList, dynamic value) {
    Map<String, dynamic> current = properties;
    for (int i = 0; i < propertyPathList.length - 1; i++) {
      current = current[propertyPathList[i]];
    }
    current[propertyPathList.last] = value;
  }

  void addChildOperation(UiPatchEvent patch) {
    this.registerComponent(patch.value as Map<String, dynamic>, patch.childId);
    (this.componentsProperties[patch.id]["children"] as List)
        .insert(patch.childIndex, patch.childId);
  }

  void removeChildOperation(UiPatchEvent patch) {
    String childId =
        (this.componentsProperties[patch.id]["children"] as List).removeAt(patch.childIndex);
    this.wrappers.remove(childId);
  }

  void replaceChildOperation(UiPatchEvent patch) {
    this.removeChildOperation(patch);
    this.addChildOperation(patch);
  }

  void patchUi(Iterable<UiPatchEvent> patches) {
    Set<String> widgetToUpdate = Set();
    patches.forEach((UiPatchEvent patch) {
      widgetToUpdate.add(patch.id);

      switch (patch.operation) {
        case UIPatchOperation.replace:
          this.replaceOperation(patch);
          break;
        case UIPatchOperation.add:
          this.addOperation(patch);
          break;
        case UIPatchOperation.remove:
          this.removeOperation(patch);
          break;
        case UIPatchOperation.addChild:
          this.addChildOperation(patch);
          break;
        case UIPatchOperation.removeChild:
          this.removeChildOperation(patch);
          break;
        case UIPatchOperation.replaceChild:
          this.replaceChildOperation(patch);
          break;
      }
    });

    widgetToUpdate.forEach((String id) {
      updateWidgetStream.add(UpdatePropsEvent(id, this.componentsProperties[id]));
    });
  }

  List<Widget> getChildrenWidgets(List<String> ids) {
    return ids.map((id) => wrappers[id]).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget app;
    if (wrappers.containsKey("/root")) {
      app = wrappers["/root"];
    } else {
      app = Text("No base component");
    }
    return Scaffold(
      body: app,
    );
  }
}
