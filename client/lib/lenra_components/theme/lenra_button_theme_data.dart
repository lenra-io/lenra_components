import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraButtonThemeData {
  LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraButtonType> backgroundColor;
  LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraButtonType> foregroundColor;
  MaterialStateProperty<EdgeInsetsGeometry> padding;
  LenraThemePropertyMapper<MaterialStateProperty<Size>, LenraButtonSize> minimumSize;
  MaterialStateProperty<TextStyle> textStyle;
  LenraThemePropertyMapper<MaterialStateProperty<BorderSide>, LenraButtonType> side;

  LenraButtonThemeData({
    LenraColorThemeData colorTheme,
    LenraBorderThemeData border,
    double horizontalPadding = 16.0,
    double sizeSmall = 24.0,
    double sizeMedium = 32.0,
    double sizeLarge = 40.0,
    LenraButtonType type = LenraButtonType.Primary,
    TextStyle textStyle = const TextStyle(color: Colors.blue),
  }) {
    colorTheme = colorTheme ?? LenraColorThemeData();
    border = border ?? LenraBorderThemeData();

    this.backgroundColor = LenraThemePropertyMapper.resolveWith((LenraButtonType type) {
      Map<LenraButtonType, MaterialStateProperty<Color>> map = {
        LenraButtonType.Primary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.primaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.primaryBackgroundHoverColor;
          }
          return colorTheme.primaryBackgroundColor;
        }),
        LenraButtonType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.secondaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.secondaryBackgroundHoverColor;
          }
          return colorTheme.secondaryBackgroundColor;
        }),
        LenraButtonType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.tertiaryBackgroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.tertiaryBackgroundHoverColor;
          }
          return colorTheme.tertiaryBackgroundColor;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(colorTheme.primaryBackgroundColor);
    });

    this.foregroundColor = LenraThemePropertyMapper.resolveWith((LenraButtonType type) {
      Map<LenraButtonType, MaterialStateProperty<Color>> map = {
        LenraButtonType.Primary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.primaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.primaryForegroundHoverColor;
          }
          return colorTheme.primaryForegroundColor;
        }),
        LenraButtonType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.secondaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.secondaryForegroundHoverColor;
          }
          return colorTheme.secondaryForegroundColor;
        }),
        LenraButtonType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorTheme.tertiaryForegroundDisabledColor;
          } else if (states.contains(MaterialState.hovered)) {
            return colorTheme.tertiaryForegroundHoverColor;
          }
          return colorTheme.tertiaryForegroundColor;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(colorTheme.primaryForegroundColor);
    });

    this.padding = MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: horizontalPadding));

    this.minimumSize = LenraThemePropertyMapper.resolveWith((LenraButtonSize size) {
      Map<LenraButtonSize, MaterialStateProperty<Size>> map = {
        LenraButtonSize.Small: MaterialStateProperty.all(Size(0, sizeSmall)),
        LenraButtonSize.Medium: MaterialStateProperty.all(Size(0, sizeMedium)),
        LenraButtonSize.Large: MaterialStateProperty.all(Size(0, sizeLarge)),
      };

      return map[size] ?? MaterialStateProperty.all(Size(0, sizeMedium));
    });

    this.textStyle = MaterialStateProperty.all(textStyle);

    this.side = LenraThemePropertyMapper.resolveWith((LenraButtonType type) {
      Map<LenraButtonType, MaterialStateProperty<BorderSide>> map = {
        LenraButtonType.Primary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return border.primaryDisabledBorder;
          } else if (states.contains(MaterialState.hovered)) {
            return border.primaryHoverBorder;
          }
          return border.primaryBorder;
        }),
        LenraButtonType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return border.secondaryDisabledBorder;
          } else if (states.contains(MaterialState.hovered)) {
            return border.secondaryHoverBorder;
          }
          return border.secondaryBorder;
        }),
        LenraButtonType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return border.tertiaryDisabledBorder;
          } else if (states.contains(MaterialState.hovered)) {
            return border.tertiaryHoverBorder;
          }
          return border.tertiaryBorder;
        }),
      };

      return map[type] ?? MaterialStateProperty.all(border.primaryBorder);
    });
  }

  LenraButtonThemeData merge(LenraButtonThemeData incoming) {
    if (incoming != null) {
      LenraButtonThemeData merged = LenraButtonThemeData();
      merged.backgroundColor = incoming.backgroundColor ?? this.backgroundColor;
      merged.foregroundColor = incoming.foregroundColor ?? this.foregroundColor;
      merged.minimumSize = incoming.minimumSize ?? this.minimumSize;
      merged.padding = incoming.padding ?? this.padding;
      merged.side = incoming.side ?? this.side;
      merged.textStyle = incoming.textStyle ?? this.textStyle;

      return merged;
    }

    return this;
  }
}
