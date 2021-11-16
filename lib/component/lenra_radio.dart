import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';

class LenraRadio<T> extends StatelessWidget {
  final LenraRadioStyle? style;
  final bool autofocus;
  final FocusNode? focusNode;
  final T? groupValue;
  final MaterialTapTargetSize? materialTapTargetSize;
  final ValueChanged<T?>? onPressed;
  final bool toggleable;
  final T value;

  const LenraRadio({
    Key? key,
    this.style,
    this.autofocus = false,
    this.focusNode,
    required this.groupValue,
    this.materialTapTargetSize,
    required this.onPressed,
    this.toggleable = false,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      activeColor: style?.activeColor,
      focusColor: style?.focusColor,
      hoverColor: style?.hoverColor,
      splashRadius: style?.splashRadius,
      visualDensity: style?.visualDensity,
      autofocus: autofocus,
      focusNode: focusNode,
      materialTapTargetSize: materialTapTargetSize,
      groupValue: groupValue,
      onChanged: onPressed,
      toggleable: toggleable,
      value: value,
    );
  }
}
