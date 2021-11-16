import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_slider_style.dart';

class LenraSlider extends StatelessWidget {
  final LenraSliderStyle? style;
  final bool autofocus;
  final int? divisions;
  final FocusNode? focusNode;
  final String? label;
  final double max;
  final double min;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<double>? onChangeStart;
  final double value;

  const LenraSlider({
    Key? key,
    this.style,
    this.autofocus = false,
    this.divisions,
    this.focusNode,
    this.label,
    this.max = 1.0,
    this.min = 0.0,
    this.onChanged,
    this.onChangeEnd,
    this.onChangeStart,
    this.value = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      autofocus: autofocus,
      divisions: divisions,
      focusNode: focusNode,
      label: label,
      max: max,
      min: min,
      onChanged: onChanged,
      onChangeEnd: onChangeEnd,
      onChangeStart: onChangeStart,
      activeColor: style?.activeColor,
      inactiveColor: style?.inactiveColor,
      thumbColor: style?.thumbColor,
    );
  }
}
