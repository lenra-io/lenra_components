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
  final TextDirection? textDirection;
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
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: children,
      direction: direction,
      spacing: _buildSpacing(context),
      runSpacing: _buildRunSpacing(context),
      crossAxisAlignment: crossAxisAlignment,
      alignment: alignment,
      runAlignment: runAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
    );
  }

  double _buildSpacing(BuildContext context) {
    var theme = LenraTheme.of(context);
    var space = spacing * theme.baseSize;
    return space;
  }

  double _buildRunSpacing(BuildContext context) {
    var theme = LenraTheme.of(context);
    var space = runSpacing * theme.baseSize;
    return space;
  }
}
