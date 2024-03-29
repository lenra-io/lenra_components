import 'package:flutter/widgets.dart';

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
    return Wrap(
      children: children,
      direction: direction,
      spacing: spacing,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      alignment: alignment,
      runAlignment: runAlignment,
      textDirection: horizontalDirection,
      verticalDirection: verticalDirection,
    );
  }
}
