import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraContainer
class LenraContainerBuilder extends LenraComponentBuilder<LenraContainer> {
  @override
  LenraContainer map({children, backgroundColor}) {
    return LenraContainer(children: children, backgroundColor: backgroundColor);
  }

  Map<String, String> get propsTypes {
    return {
      "children": "List<Widget>",
      "backgroundColor": "Color",
    };
  }
}

class LenraContainer extends StatelessLenraComponent {
  final List<Widget> children;
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
