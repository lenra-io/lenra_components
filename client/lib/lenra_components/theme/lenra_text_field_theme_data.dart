import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

import 'lenra_color_theme_data.dart';

class LenraTextFieldThemeData {
  LenraColorThemeData colorTheme;
  LenraBorderThemeData border;
  Color descriptionColor;
  TextStyle textStyle;
  LenraThemePropertyMapper<double, LenraTextFieldSize> height;
  double fontSize;

  LenraTextFieldThemeData({
    this.colorTheme,
    this.border,
    this.fontSize = 14.0,
    double sizeSmall = 24.0,
    double sizeMedium = 32.0,
    double sizeLarge = 40.0,
    this.descriptionColor,
  }) {
    this.colorTheme = colorTheme ?? LenraColorThemeData();
    this.descriptionColor =
        descriptionColor ?? LenraColorThemeData.LENRA_GREY_TEXT;
    this.border = border ??
        LenraBorderThemeData(
          primaryBorder: BorderSide(color: Colors.grey),
          primaryHoverBorder: BorderSide(color: LenraColorThemeData.LENRA_BLUE),
          primaryDisabledBorder:
              BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY),
          secondaryBorder: BorderSide(color: Colors.red),
        );

    this.height = LenraThemePropertyMapper.resolveWith(
      (LenraTextFieldSize size) {
        Map<LenraTextFieldSize, double> map = {
          LenraTextFieldSize.Small: sizeSmall,
          LenraTextFieldSize.Medium: sizeMedium,
          LenraTextFieldSize.Large: sizeLarge,
        };
        return map[size] ?? sizeMedium;
      },
    );
  }

  LenraTextFieldThemeData merge(LenraTextFieldThemeData incoming) {
    if (incoming != null) {
      LenraTextFieldThemeData merged = LenraTextFieldThemeData();
      merged.colorTheme = incoming.colorTheme ?? this.colorTheme;
      merged.border = incoming.border ?? this.border;
      merged.textStyle = incoming.textStyle ?? this.textStyle;

      return merged;
    }

    return this;
  }
}
