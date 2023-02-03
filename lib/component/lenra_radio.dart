import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';

class LenraRadio<T> extends StatelessWidget {
  /// The value of the LenraRadio.
  final T value;

  /// The selected value for a group of LenraRadio.
  final T? groupValue;

  /// The callback when the LenraRadio is clicked.
  final ValueChanged<T?>? onPressed;

  /// The style of the LenraRadio.
  final LenraRadioStyle? style;

  /// Whether this LenraRadio is focused initially.
  final bool autofocus;
  final FocusNode? focusNode;
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether the LenraRadio can be unselected after selecting it.
  final bool toggleable;

  const LenraRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.materialTapTargetSize,
    this.toggleable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget res = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onPressed,
      activeColor: style?.activeColor,
      focusColor: style?.focusColor,
      hoverColor: style?.hoverColor,
      splashRadius: style?.splashRadius,
      visualDensity: style?.visualDensity,
      autofocus: autofocus,
      focusNode: focusNode,
      materialTapTargetSize: materialTapTargetSize,
      toggleable: toggleable,
    );

    if (style?.unselectedColor != null) {
      return Theme(
        data: Theme.of(context).copyWith(unselectedWidgetColor: style?.unselectedColor),
        child: res,
      );
    }

    return res;
  }
}
