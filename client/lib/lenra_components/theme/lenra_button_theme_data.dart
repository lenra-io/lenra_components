import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraButtonThemeData {
  LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraComponentType> backgroundColor;
  LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraComponentType> foregroundColor;
  LenraThemePropertyMapper<EdgeInsetsGeometry, LenraComponentSize> padding;
  LenraThemePropertyMapper<MaterialStateProperty<BorderSide>, LenraComponentType> side;
  final LenraThemeData lenraTheme;

  LenraButtonThemeData({
    this.lenraTheme,
  }) {
    this.backgroundColor = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.primaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.primaryBackgroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.primaryBackgroundColor;
        }),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.secondaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.secondaryBackgroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.secondaryBackgroundColor;
        }),
        LenraComponentType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.tertiaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.tertiaryBackgroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.tertiaryBackgroundColor;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(lenraTheme.lenraColorThemeData.primaryBackgroundColor);
    });

    this.foregroundColor = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.primaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.primaryForegroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.primaryForegroundColor;
        }),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.secondaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.secondaryForegroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.secondaryForegroundColor;
        }),
        LenraComponentType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraColorThemeData.tertiaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraColorThemeData.tertiaryForegroundHoverColor;
          }
          return lenraTheme.lenraColorThemeData.tertiaryForegroundColor;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(lenraTheme.lenraColorThemeData.primaryForegroundColor);
    });

    this.padding = LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return lenraTheme.paddingMap[size] ?? lenraTheme.paddingMap[LenraComponentSize.Medium];
    });

    this.side = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<BorderSide>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          return null;
        }),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lenraTheme.lenraBorderThemeData.secondaryDisabledBorder;
          } else if (states.contains(MaterialState.hovered)) {
            return lenraTheme.lenraBorderThemeData.secondaryHoverBorder;
          }
          return lenraTheme.lenraBorderThemeData.secondaryBorder;
        }),
        LenraComponentType.Tertiary: MaterialStateProperty.resolveWith((states) {
          return null;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(lenraTheme.lenraBorderThemeData.primaryBorder);
    });
  }

  ButtonStyle getStyle(LenraComponentType type) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(this.lenraTheme.lenraTextThemeData.bodyText),
      foregroundColor: this.foregroundColor.resolve(type),
      backgroundColor: this.backgroundColor.resolve(type),
      side: this.side.resolve(type),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  EdgeInsetsGeometry getPadding(LenraComponentSize size) {
    return this.padding.resolve(size);
  }
}
