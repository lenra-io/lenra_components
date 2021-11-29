import 'package:flutter/widgets.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

class LenraContainer extends StatelessWidget {
  /// The child of the `LenraContainer`.
  final Widget child;

  /// The padding around the `LenraContainer`.
  final EdgeInsets? padding;

  /// The constraints to apply to the `LenraContainer`.
  final BoxConstraints? constraints;

  /// The decoration of the `LenraContainer`.
  final BoxDecoration? decoration;

  final BoxBorder? border;

  const LenraContainer({
    Key? key,
    required this.child,
    this.padding,
    this.constraints,
    this.decoration,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);

    return Container(
      child: child,
      padding: padding != null ? padding! * theme.baseSize : padding,
      constraints: constraints,
      decoration: decoration == null ? BoxDecoration(border: border) : decoration!.copyWith(border: border),
    );
  }
}
