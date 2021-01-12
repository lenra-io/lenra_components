import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component_wrapper.dart';

// TODO : generate this from annotation on LenraContainer
extension LenraContainerExt on LenraContainer {
  static LenraContainer create({children, backgroundColor}) {
    return LenraContainer(children: children, backgroundColor: backgroundColor);
  }

  static const Map<String, String> propsTypes = {
    "children": "List<LenraComponentWrapper>",
    "backgroundColor": "Color"
  };
}

class LenraContainer extends StatelessLenraComponent {
  final List<LenraComponentWrapper> children;
  final Color backgroundColor;

  LenraContainer({
    this.children = const [],
    this.backgroundColor,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: this.backgroundColor,
        child: Wrap(
          children: this.children,
        ));
  }
}
