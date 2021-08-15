import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraRadioThemeData {
  late MaterialStateProperty<Color> fillColor;
  final LenraThemeData lenraThemeData;
  final Function(Set<MaterialState>, LenraColorThemeData)? backgroundColor;
  final Function(bool, LenraTextThemeData)? textStyle;

  LenraRadioThemeData({
    required this.lenraThemeData,
    this.backgroundColor,
    this.textStyle,
  }) {
    this.fillColor = MaterialStateProperty.resolveWith((states) {
      if (backgroundColor != null) {
        return backgroundColor!(
            states, this.lenraThemeData.lenraColorThemeData);
      } else {
        if (states.contains(MaterialState.disabled)) {
          return lenraThemeData
              .lenraColorThemeData.primaryBackgroundDisabledColor;
        } else {
          return lenraThemeData.lenraColorThemeData.primaryBackgroundColor;
        }
      }
    });
  }

  TextStyle getTextStyle(bool disabled) {
    if (textStyle != null) {
      return textStyle!(disabled, this.lenraThemeData.lenraTextThemeData);
    } else {
      return disabled
          ? lenraThemeData.lenraTextThemeData.disabledBodyText
          : lenraThemeData.lenraTextThemeData.blueBodyText;
    }
  }

  LenraRadioThemeData copyWith(LenraRadioThemeData incoming) {
    return LenraRadioThemeData(
      lenraThemeData: lenraThemeData,
      backgroundColor: incoming.backgroundColor ?? this.backgroundColor,
      textStyle: incoming.textStyle ?? this.textStyle,
    );
  }
}
