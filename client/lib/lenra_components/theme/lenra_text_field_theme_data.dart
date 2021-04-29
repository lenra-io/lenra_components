import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraTextFieldThemeData {
  LenraColorThemeData colorTheme;
  LenraBorderThemeData border;
  TextStyle textStyle;
  LenraThemePropertyMapper<Size, LenraTextFieldSize> minimumSize;
  LenraThemePropertyMapper<Size, LenraTextFieldSize> fontSize;

  LenraTextFieldThemeData({
    this.colorTheme,
    this.border,
    double sizeSmall = 24.0,
    double sizeMedium = 32.0,
    double sizeLarge = 40.0,
  }) {
    this.colorTheme = colorTheme ?? LenraColorThemeData();
    this.border = border ??
        LenraBorderThemeData(
          primaryBorder: BorderSide(color: Colors.grey),
          primaryHoverBorder: BorderSide(color: LenraColorThemeData.LENRA_BLUE),
          primaryDisabledBorder: BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY),
          secondaryBorder: BorderSide(color: Colors.red),
        );

    this.minimumSize = LenraThemePropertyMapper.resolveWith(
      (LenraTextFieldSize size) {
        Map<LenraTextFieldSize, Size> map = {
          LenraTextFieldSize.Small: Size(0, sizeSmall),
          LenraTextFieldSize.Medium: Size(0, sizeMedium),
          LenraTextFieldSize.Large: Size(0, sizeLarge),
        };
        return map[size] ?? Size(0, sizeMedium);
      },
    );

    this.fontSize = LenraThemePropertyMapper.resolveWith(
      (LenraTextFieldSize size) {
        Map<LenraTextFieldSize, Size> map = {
          LenraTextFieldSize.Small: Size(0, 12),
          LenraTextFieldSize.Medium: Size(0, 14),
          LenraTextFieldSize.Large: Size(0, 16),
        };
        return map[size] ?? Size(0, 12);
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
