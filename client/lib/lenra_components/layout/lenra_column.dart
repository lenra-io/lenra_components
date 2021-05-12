import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraColumn extends StatelessWidget {
  final List<Widget> children;
  final double separationFactor;

  LenraColumn({
    Key key,
    this.separationFactor = 1,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (separationFactor <= 0) return Column(children: children);

    var theme = LenraTheme.of(context);
    List<Widget> colChildren = [];
    children.asMap().forEach((key, value) {
      if (key > 0) colChildren.add(SizedBox(height: separationFactor * theme.baseSize));
      colChildren.add(value);
    });

    return Column(children: colChildren);
  }
}
