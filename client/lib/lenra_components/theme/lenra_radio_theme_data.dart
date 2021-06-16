import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraRadioThemeData {
  late MaterialStateProperty<Color> fillColor;
  LenraThemeData lenraTheme;

  LenraRadioThemeData({
    required this.lenraTheme,
  }) {
    this.fillColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return lenraTheme.lenraColorThemeData.primaryBackgroundDisabledColor;
      } else {
        return lenraTheme.lenraColorThemeData.primaryBackgroundColor;
      }
    });
  }

  TextStyle getTextStyle(bool disabled) {
    return TextStyle(
      color: disabled
          ? lenraTheme.lenraColorThemeData.secondaryForegroundDisabledColor
          : lenraTheme.lenraColorThemeData.secondaryForegroundColor,
    );
  }
}
