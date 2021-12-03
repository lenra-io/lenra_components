import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';

class LenraCheckbox extends StatelessWidget {
  final bool? value;
  final bool tristate;
  final ValueChanged<bool?>? onPressed;
  final LenraCheckboxStyle? style;
  final MaterialTapTargetSize? materialTapTargetSize;
  final FocusNode? focusNode;
  final bool autofocus;

  const LenraCheckbox({
    Key? key,
    required this.value,
    this.tristate = false,
    required this.onPressed,
    this.style,
    this.materialTapTargetSize,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      tristate: tristate,
      onChanged: onPressed,
      materialTapTargetSize: materialTapTargetSize,
      focusNode: focusNode,
      autofocus: autofocus,
      activeColor: style?.activeColor,
      checkColor: style?.checkColor,
      focusColor: style?.focusColor,
      hoverColor: style?.hoverColor,
      splashRadius: style?.splashRadius,
      visualDensity: style?.visualDensity,
      shape: style?.shape,
      side: style?.side,
    );
  }
}
