import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

import 'lenra_color_theme_data.dart';

class LenraTextFieldThemeData {
  LenraColorThemeData colorTheme;
  LenraBorderThemeData border;
  LenraTextThemeData textTheme;
  Color descriptionColor;
  TextStyle textStyle;
  TextStyle descriptionStyle;
  TextStyle hintTextStyle;
  double fontSize;
  Map<LenraComponentSize, EdgeInsets> paddingMap;

  LenraTextFieldThemeData({
    this.colorTheme,
    this.border,
    this.fontSize = 14.0,
    this.descriptionColor,
    this.paddingMap,
    this.textStyle,
    this.descriptionStyle,
    this.hintTextStyle,
  }) {
    this.colorTheme = colorTheme ?? LenraColorThemeData();
    this.textTheme = textTheme ?? LenraTextThemeData();
    this.descriptionColor = descriptionColor ?? LenraColorThemeData.LENRA_GREY_TEXT;
    this.border = border ??
        LenraBorderThemeData(
          primaryBorder: BorderSide(color: Colors.grey),
          primaryHoverBorder: BorderSide(color: LenraColorThemeData.LENRA_BLUE),
          primaryDisabledBorder: BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY),
          secondaryBorder: BorderSide(color: Colors.red),
        );
  }

  LenraTextFieldThemeData merge(LenraTextFieldThemeData incoming) {
    if (incoming != null) {
      LenraTextFieldThemeData merged = LenraTextFieldThemeData();
      merged.colorTheme = incoming.colorTheme ?? this.colorTheme;
      merged.border = incoming.border ?? this.border;
      merged.textStyle = incoming.textStyle ?? this.textStyle;
      merged.descriptionStyle = incoming.descriptionStyle ?? this.descriptionStyle;
      merged.hintTextStyle = incoming.hintTextStyle ?? this.hintTextStyle;
      merged.paddingMap = incoming.paddingMap ?? this.paddingMap;

      return merged;
    }

    return this;
  }
}
