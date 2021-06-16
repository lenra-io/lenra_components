import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraFlex extends StatelessWidget {
  final List<Widget> children;
  final double separationFactor;
  final bool fillParent;
  final CrossAxisAlignment crossAxisAlignment;

  final Axis direction;

  LenraFlex({
    Key? key,
    this.separationFactor = 1,
    this.fillParent: false,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> colChildren = children;
    if (separationFactor > 0) {
      var theme = LenraTheme.of(context);
      colChildren = [];
      var space = separationFactor * theme.baseSize;
      children.asMap().forEach((key, value) {
        if (key > 0)
          colChildren.add(SizedBox(
            width: this.direction == Axis.horizontal ? space : 0,
            height: this.direction == Axis.vertical ? space : 0,
          ));
        colChildren.add(value);
      });
    }

    return Flex(
      mainAxisSize: fillParent ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: this.crossAxisAlignment,
      direction: this.direction,
      children: colChildren,
    );
  }
}
