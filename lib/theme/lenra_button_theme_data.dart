import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraButtonThemeData {
  late LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraComponentType> backgroundColor;
  late LenraThemePropertyMapper<MaterialStateProperty<Color>, LenraComponentType> foregroundColor;
  late LenraThemePropertyMapper<MaterialStateProperty<BorderSide>, LenraComponentType> side;
  late LenraThemePropertyMapper<EdgeInsetsGeometry, LenraComponentSize> padding;
  final LenraThemeData lenraThemeData;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? primaryBackgroundColor;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? secondaryBackgroundColor;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? tertiaryBackgroundColor;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? primaryForegroundColor;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? secondaryForegroundColor;
  final Color Function(Set<MaterialState>, LenraColorThemeData)? tertiaryForegroundColor;
  final BorderSide Function(Set<MaterialState>, LenraColorThemeData)? primaryBorder;
  final BorderSide Function(Set<MaterialState>, LenraColorThemeData)? secondaryBorder;
  final BorderSide Function(Set<MaterialState>, LenraColorThemeData)? tertiaryBorder;

  LenraButtonThemeData({
    required this.lenraThemeData,
    this.primaryBackgroundColor,
    this.secondaryBackgroundColor,
    this.tertiaryBackgroundColor,
    this.primaryForegroundColor,
    this.secondaryForegroundColor,
    this.tertiaryForegroundColor,
    this.primaryBorder,
    this.secondaryBorder,
    this.tertiaryBorder,
  }) {
    backgroundColor = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      final Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (primaryBackgroundColor != null) {
            return primaryBackgroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.primaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.primaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.primaryBackgroundColor;
          }
        }),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (secondaryBackgroundColor != null) {
            return secondaryBackgroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.secondaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.secondaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.secondaryBackgroundColor;
          }
        }),
        LenraComponentType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (tertiaryBackgroundColor != null) {
            return tertiaryBackgroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.tertiaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.tertiaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.tertiaryBackgroundColor;
          }
        }),
      };

      return map[type] ?? MaterialStateProperty.all(lenraThemeData.lenraColorThemeData.primaryBackgroundColor);
    });

    foregroundColor = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      final Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (primaryForegroundColor != null) {
            return primaryForegroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.primaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.primaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.primaryForegroundColor;
          }
        }),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (secondaryForegroundColor != null) {
            return secondaryForegroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.secondaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.secondaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.secondaryForegroundColor;
          }
        }),
        LenraComponentType.Tertiary: MaterialStateProperty.resolveWith((states) {
          if (tertiaryForegroundColor != null) {
            return tertiaryForegroundColor!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraColorThemeData.tertiaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraColorThemeData.tertiaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.tertiaryForegroundColor;
          }
        }),
      };

      return map[type] ?? MaterialStateProperty.all(lenraThemeData.lenraColorThemeData.primaryForegroundColor);
    });

    side = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      final Map<LenraComponentType, MaterialStateProperty<BorderSide>?> map = {
        LenraComponentType.Primary: (primaryBorder != null)
            ? MaterialStateProperty.resolveWith((states) {
                return primaryBorder!(states, lenraThemeData.lenraColorThemeData);
              })
            : MaterialStateProperty.all(BorderSide.none),
        LenraComponentType.Secondary: MaterialStateProperty.resolveWith((states) {
          if (secondaryBorder != null) {
            return secondaryBorder!(states, lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData.lenraBorderThemeData.secondaryDisabledBorder;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraBorderThemeData.secondaryHoverBorder;
            }
            return lenraThemeData.lenraBorderThemeData.secondaryBorder;
          }
        }),
        LenraComponentType.Tertiary: (tertiaryBorder != null)
            ? MaterialStateProperty.resolveWith((states) {
                return tertiaryBorder!(states, lenraThemeData.lenraColorThemeData);
              })
            : MaterialStateProperty.all(BorderSide.none),
      };

      return map[type] ?? MaterialStateProperty.all(lenraThemeData.lenraBorderThemeData.primaryBorder);
    });

    padding = LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return lenraThemeData.paddingMap[size] ?? lenraThemeData.paddingMap[LenraComponentSize.Medium]!;
    });
  }

  ButtonStyle getStyle(LenraComponentType type) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(lenraThemeData.lenraTextThemeData.bodyText),
      foregroundColor: foregroundColor.resolve(type),
      backgroundColor: backgroundColor.resolve(type),
      side: side.resolve(type),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  EdgeInsetsGeometry getPadding(LenraComponentSize size) {
    return padding.resolve(size);
  }

  LenraButtonThemeData copyWith(LenraButtonThemeData incoming) {
    return LenraButtonThemeData(
      lenraThemeData: lenraThemeData,
      primaryBackgroundColor: incoming.primaryBackgroundColor ?? primaryBackgroundColor,
      secondaryBackgroundColor: incoming.secondaryBackgroundColor ?? secondaryBackgroundColor,
      tertiaryBackgroundColor: incoming.tertiaryBackgroundColor ?? tertiaryBackgroundColor,
      primaryForegroundColor: incoming.primaryForegroundColor ?? primaryForegroundColor,
      secondaryForegroundColor: incoming.secondaryForegroundColor ?? secondaryForegroundColor,
      tertiaryForegroundColor: incoming.tertiaryForegroundColor ?? tertiaryForegroundColor,
      primaryBorder: incoming.primaryBorder ?? primaryBorder,
      secondaryBorder: incoming.secondaryBorder ?? secondaryBorder,
      tertiaryBorder: incoming.tertiaryBorder ?? tertiaryBorder,
    );
  }
}
