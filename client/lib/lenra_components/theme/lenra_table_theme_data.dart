import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraTableThemeData {
  LenraColorThemeData colorTheme;
  LenraBorderThemeData border;
  Map<LenraComponentSize, EdgeInsets> paddingMap;
  LenraThemePropertyMapper<EdgeInsetsGeometry, LenraComponentSize> padding;

  LenraTableThemeData({
    this.colorTheme,
    this.border,
    this.paddingMap,
  }) {
    this.colorTheme = colorTheme ?? LenraColorThemeData();
    this.border = border ??
        LenraBorderThemeData(
          primaryBorder: BorderSide(color: Colors.grey),
          primaryHoverBorder: BorderSide(color: LenraColorThemeData.LENRA_BLUE),
          primaryDisabledBorder: BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY),
          secondaryBorder: BorderSide(color: Colors.red),
        );
    this.padding = LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return paddingMap[size] ?? paddingMap[LenraComponentSize.Medium];
    });
  }

  LenraTableThemeData merge(LenraTableThemeData incoming) {
    if (incoming != null) {
      return LenraTableThemeData(
        colorTheme: incoming.colorTheme ?? this.colorTheme,
        border: incoming.border ?? this.border,
      );
    } else {
      return this;
    }
  }
}
