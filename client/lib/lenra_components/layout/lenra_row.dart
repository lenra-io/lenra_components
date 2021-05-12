import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraRow extends StatelessWidget {
  final List<Widget> children;
  final double separationFactor;

  LenraRow({
    Key key,
    this.separationFactor = 1,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (separationFactor <= 0) return Row(children: children);

    var theme = LenraTheme.of(context);
    List<Widget> rowChildren = [];
    children.asMap().forEach((key, value) {
      if (key > 0) rowChildren.add(SizedBox(width: separationFactor * theme.baseSize));
      rowChildren.add(value);
    });

    return Row(
      children: rowChildren,
      mainAxisSize: MainAxisSize.min,
    );
  }
}
