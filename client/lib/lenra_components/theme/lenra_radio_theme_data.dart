import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

class LenraRadioThemeData {
  MaterialStateProperty<Color> fillColor;
  LenraColorThemeData colorTheme;
  LenraBorderThemeData border;
  LenraRadioThemeData({
    this.colorTheme,
    this.border,
  }) {
    this.colorTheme = colorTheme ??
        LenraColorThemeData(secondaryForegroundColor: Colors.black, secondaryForegroundDisabledColor: Colors.black12);
    this.border = border ?? LenraBorderThemeData();

    this.fillColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colorTheme.primaryBackgroundDisabledColor;
      } else {
        return colorTheme.primaryBackgroundColor;
      }
    });
  }

  LenraRadioThemeData merge(LenraRadioThemeData incoming) {
    if (incoming != null) {
      return LenraRadioThemeData(
        colorTheme: incoming.colorTheme ?? this.colorTheme,
        border: incoming.border ?? this.border,
      );
    } else {
      return this;
    }
  }
}
