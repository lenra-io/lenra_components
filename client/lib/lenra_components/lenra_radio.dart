import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_stateful_component.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraRadio extends LenraStatefulComponent {
  static Function update;
  static Function onChanged;
  static Function getChanged;
  final String text;
  final int value;
  final bool disabled;
  final String fontStyle;
  final LenraRadioThemeData lenraRadioThemeData;
  @override
  final GlobalKey<_LenraRadio> key = new GlobalKey<_LenraRadio>();

  LenraRadio({
    this.text,
    this.value,
    this.disabled = false,
    this.fontStyle,
    this.lenraRadioThemeData,
  });

  @override
  _LenraRadio createState() {
    return _LenraRadio(
      onChanged: onChanged,
      getChanged: getChanged,
      text: this.text,
      value: this.value,
      disabled: this.disabled,
      fontStyle: this.fontStyle,
      update: update,
      lenraRadioThemeData: this.lenraRadioThemeData,
    );
  }
}

class _LenraRadio extends State<LenraRadio> {
  Function onChanged;
  Function getChanged;
  final String text;
  final int value;
  final bool disabled;
  final String fontStyle;
  final LenraRadioThemeData lenraRadioThemeData;
  Function update;

  _LenraRadio({
    this.onChanged,
    this.getChanged,
    this.text,
    this.value,
    this.disabled = false,
    this.fontStyle,
    this.lenraRadioThemeData,
    this.update,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LenraRadioThemeData finalLenraRadioThemeData =
        LenraTheme.of(context).lenraRadioThemeData.merge(this.lenraRadioThemeData);

    if (this.text != null) {
      return Row(
        children: <Widget>[
          Radio<int>(
            value: this.value,
            groupValue: getChanged(),
            fillColor: finalLenraRadioThemeData.fillColor,
            onChanged: this.disabled
                ? null
                : (value) {
                    setState(() {
                      onChanged(value);
                      update();
                    });
                  },
          ),
          Text(
            this.text,
            style: TextStyle(
                color: this.disabled
                    ? finalLenraRadioThemeData.colorTheme.secondaryForegroundDisabledColor
                    : finalLenraRadioThemeData.colorTheme.secondaryForegroundColor,
                fontFamily: this.fontStyle),
          ),
        ],
      );
    } else {
      return Radio<int>(
        value: this.value,
        groupValue: getChanged(),
        fillColor: finalLenraRadioThemeData.fillColor,
        onChanged: this.disabled
            ? null
            : (value) {
                setState(() {
                  onChanged(value);
                  update();
                });
              },
      );
    }
  }
}
