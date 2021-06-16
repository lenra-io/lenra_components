import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_flex.dart';

// TODO : generate this from annotation on LenraContainer
class LenraContainerBuilder extends LenraComponentBuilder<LenraContainer> {
  @override
  LenraContainer map({children, backgroundColor, direction}) {
    return LenraContainer(children: children, backgroundColor: backgroundColor, direction: direction);
  }

  Map<String, String> get propsTypes {
    return {
      "children": "List<Widget>",
      "backgroundColor": "Color",
      "direction": "String",
    };
  }
}

class LenraContainer extends StatelessLenraComponent {
  final List<Widget> children;
  final Color? backgroundColor;
  final String? direction;

  LenraContainer({
    required this.children,
    required this.backgroundColor,
    required this.direction,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Axis direction;

    if (this.direction == "col") {
      direction = Axis.vertical;
    } else {
      direction = Axis.horizontal;
    }

    return Container(
      color: this.backgroundColor,
      child: LenraFlex(
        direction: direction,
        children: this.children,
      ),
    );
  }
}
