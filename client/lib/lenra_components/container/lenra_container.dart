import 'package:flutter/material.dart';
import 'package:fr_lenra_client/apps/lenra_app_data_provider.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';
import 'package:fr_lenra_client/socket/ui_patch_event.dart';

class LenraContainerState extends LenraComponentState {
  List<LenraComponent> children;

  LenraContainerState({
    String id,
    LenraComponentState parent,
    Map<String, dynamic> properties,
    Map<String, dynamic> styles,
    Stream stream,
  }) : super(
          id: id,
          parent: parent,
          properties: properties,
          styles: styles,
          stream: stream,
        ) {
    List<dynamic> jsonChild = this.properties['children'] as List<dynamic>;

    // TODO : Attention, O(n²)
    int i = 0;
    this.children = jsonChild.map<LenraComponent>((e) {
      return this._createChild(i++, e);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: if (this.parent is LenraContainer) Child is not Wrap()
    Widget container = Wrap(
      children: this.children,
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
    );
    return this._buildChild(context, container);
  }

  Widget _buildChild(BuildContext context, Widget container) {
    String hex;
    if (this.properties['backgroundColor'] != null) {
      hex = this.properties['backgroundColor'].replaceFirst('#', '');
    }

    if (this.parent == null) {
      LenraApplicationInfo appInfo = LenraAppDataProvider.of(context).appInfo;
      return Scaffold(
          body: InteractiveViewer(child: container),
          backgroundColor:
              hex != null ? Color(int.parse('FF$hex', radix: 16)) : null,
          appBar: AppBar(
              actionsIconTheme: IconThemeData(),
              title: Text(
                this.properties['title'] ?? appInfo.name,
                style: TextStyle(
                    color: appInfo.color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white),
              ),
              centerTitle: true));
    } else {
      Widget comp = container;
      if (this.properties['title'] != null) {
        comp = Column(children: [
          Row(
              children: [Text(this.properties['title'])],
              mainAxisSize: MainAxisSize.max),
          Expanded(child: container)
        ]);
      }
      return Container(
        color: hex != null ? Color(int.parse('FF$hex', radix: 16)) : null,
        child: comp,
      );
    }
  }

  LenraComponent _createChild(int index, Map<String, dynamic> childProperties) {
    return LenraComponent.create(
      childProperties,
      id: '${this.id}/children/$index',
      parent: this,
      styles: this.styles,
    );
  }

  void _addChild(int childIndex, Map<String, dynamic> properties) {
    this.properties['children'].insert(childIndex, properties);
    this.children.insert(
          childIndex,
          this._createChild(childIndex, properties),
        );
  }

  void _removeChild(int childIndex) {
    this.children.removeAt(childIndex);
    this.properties['children'].removeAt(childIndex);
  }

  @override
  void replaceChildTypeOperation(UiPatchEvent event) {
    setState(() {
      Map<String, dynamic> childProperties =
          this.children[event.childIndex].properties;
      childProperties[event.property] = event.value;

      this._removeChild(event.childIndex);
      this._addChild(event.childIndex, childProperties);
    });
  }

  @override
  void replaceChildOperation(UiPatchEvent event) {
    setState(() {
      this._removeChild(event.childIndex);
      this._addChild(event.childIndex, event.value);
    });
  }

  @override
  void addChildOperation(UiPatchEvent event) {
    setState(() {
      this._addChild(event.childIndex, event.value);
    });
  }

  @override
  void removeChildOperation(UiPatchEvent event) {
    setState(() {
      this._removeChild(event.childIndex);
    });
  }
}
