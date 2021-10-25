import 'package:flutter/widgets.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

class LenraStyledContainer extends StatelessWidget {
  final Widget child;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  const LenraStyledContainer({
    Key? key,
    required this.child,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.padding,
    this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);

    return Container(
      child: child,
      padding: padding != null ? padding! * theme.baseSize : padding,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
      ),
      constraints: constraints,
    );
  }
}
