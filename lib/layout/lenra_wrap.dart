import 'package:flutter/widgets.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

class LenraWrap extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final double spacing;
  final double runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final TextDirection? horizontalDirection;
  final VerticalDirection verticalDirection;

  const LenraWrap({
    Key? key,
    required this.children,
    this.direction = Axis.horizontal,
    this.spacing = 0,
    this.runSpacing = 0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.horizontalDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    return Wrap(
      children: children,
      direction: direction,
      spacing: spacing * theme.baseSize,
      runSpacing: runSpacing * theme.baseSize,
      crossAxisAlignment: crossAxisAlignment,
      alignment: alignment,
      runAlignment: runAlignment,
      textDirection: horizontalDirection,
      verticalDirection: verticalDirection,
    );
  }
}
