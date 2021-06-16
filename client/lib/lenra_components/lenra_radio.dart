import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraRadio<T> extends StatelessWidget {
  final String? label;
  final T value;
  final T groupValue;
  final bool disabled;
  final void Function(T?)? onChanged;

  LenraRadio({
    this.label,
    required this.value,
    required this.groupValue,
    @required this.onChanged,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraRadioThemeData finalLenraRadioThemeData = LenraTheme.of(context).lenraRadioThemeData;

    Widget radio = Radio<T>(
      value: this.value,
      groupValue: this.groupValue,
      fillColor: finalLenraRadioThemeData.fillColor,
      onChanged: this.disabled ? null : this.onChanged ?? (e) => null,
    );

    if (this.label == null) return radio;

    return Row(
      children: <Widget>[
        radio,
        Text(this.label!, style: finalLenraRadioThemeData.getTextStyle(disabled)),
      ],
    );
  }
}
