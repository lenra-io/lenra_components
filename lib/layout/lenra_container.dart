import 'package:flutter/widgets.dart';

class LenraContainer extends StatelessWidget {
  /// The child of the `LenraContainer`.
  final Widget child;

  /// The padding around the `LenraContainer`.
  final EdgeInsets? padding;

  final BoxBorder? border;

  /// The constraints to apply to the `LenraContainer`.
  final BoxConstraints? constraints;

  /// The decoration of the `LenraContainer`.
  final BoxDecoration? decoration;

  const LenraContainer({
    Key? key,
    required this.child,
    this.padding,
    this.border,
    this.constraints,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      constraints: constraints,
      decoration: decoration == null ? BoxDecoration(border: border) : decoration!.copyWith(border: border),
    );
  }
}
