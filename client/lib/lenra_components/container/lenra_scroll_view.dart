import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/container/lenra_container.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

class LenraScrollViewState extends LenraContainerState {
  LenraScrollViewState(
      {String id,
      LenraComponentState parent,
      Map<String, dynamic> properties,
      Map<String, dynamic> styles,
      Stream stream})
      : super(
            id: id,
            parent: parent,
            properties: properties,
            styles: styles,
            stream: stream) {
    // Ici on envoi crée les enfants
    List<dynamic> jsonChild = this.properties['children'] as List<dynamic>;
    this.children = jsonChild
        .map<LenraComponent>((e) => LenraComponent.create(e,
            styles: styles,
            parent: this,
            id: '${this.id}/children/${jsonChild.indexOf(e)}'))
        .toList();
  }

  List<LenraComponent> children;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: this.children,
        scrollDirection: this.properties['alignment'] == 'horizontal'
            ? Axis.horizontal
            : Axis.vertical);
  }
}
