import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraButtonThemeData {
  late LenraThemePropertyMapper<MaterialStateProperty<Color>,
      LenraComponentType> backgroundColor;
  late LenraThemePropertyMapper<MaterialStateProperty<Color>,
      LenraComponentType> foregroundColor;
  late LenraThemePropertyMapper<MaterialStateProperty<BorderSide>,
      LenraComponentType> side;
  late LenraThemePropertyMapper<dynamic, LenraComponentSize> padding;
  final LenraThemeData lenraThemeData;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      primaryBackgroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      secondaryBackgroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      tertiaryBackgroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      primaryForegroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      secondaryForegroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)?
      tertiaryForegroundColor;
  final Function(Set<MaterialState>, LenraColorThemeData)? primaryBorder;
  final Function(Set<MaterialState>, LenraColorThemeData)? secondaryBorder;
  final Function(Set<MaterialState>, LenraColorThemeData)? tertiaryBorder;

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
    this.backgroundColor =
        LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (primaryBackgroundColor != null) {
            return primaryBackgroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.primaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.primaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.primaryBackgroundColor;
          }
        }),
        LenraComponentType.Secondary:
            MaterialStateProperty.resolveWith((states) {
          if (secondaryBackgroundColor != null) {
            return secondaryBackgroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.secondaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.secondaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.secondaryBackgroundColor;
          }
        }),
        LenraComponentType.Tertiary:
            MaterialStateProperty.resolveWith((states) {
          if (tertiaryBackgroundColor != null) {
            return tertiaryBackgroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.tertiaryBackgroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.tertiaryBackgroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.tertiaryBackgroundColor;
          }
        }),
      };

      return map[type] ??
          MaterialStateProperty.all(
              lenraThemeData.lenraColorThemeData.primaryBackgroundColor);
    });

    this.foregroundColor =
        LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<Color>> map = {
        LenraComponentType.Primary: MaterialStateProperty.resolveWith((states) {
          if (primaryForegroundColor != null) {
            return primaryForegroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.primaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.primaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.primaryForegroundColor;
          }
        }),
        LenraComponentType.Secondary:
            MaterialStateProperty.resolveWith((states) {
          if (secondaryForegroundColor != null) {
            return secondaryForegroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.secondaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.secondaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.secondaryForegroundColor;
          }
        }),
        LenraComponentType.Tertiary:
            MaterialStateProperty.resolveWith((states) {
          if (tertiaryForegroundColor != null) {
            return tertiaryForegroundColor!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraColorThemeData.tertiaryForegroundDisabledColor;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData
                  .lenraColorThemeData.tertiaryForegroundHoverColor;
            }
            return lenraThemeData.lenraColorThemeData.tertiaryForegroundColor;
          }
        }),
      };

      return map[type] ??
          MaterialStateProperty.all(
              lenraThemeData.lenraColorThemeData.primaryForegroundColor);
    });

    this.side = LenraThemePropertyMapper.resolveWith((LenraComponentType type) {
      Map<LenraComponentType, MaterialStateProperty<BorderSide>?> map = {
        LenraComponentType.Primary: (primaryBorder != null)
            ? MaterialStateProperty.resolveWith((states) {
                return primaryBorder!(
                    states, this.lenraThemeData.lenraColorThemeData);
              })
            : MaterialStateProperty.all(BorderSide.none),
        LenraComponentType.Secondary:
            MaterialStateProperty.resolveWith((states) {
          if (secondaryBorder != null) {
            return secondaryBorder!(
                states, this.lenraThemeData.lenraColorThemeData);
          } else {
            if (states.contains(MaterialState.disabled)) {
              return lenraThemeData
                  .lenraBorderThemeData.secondaryDisabledBorder;
            } else if (states.contains(MaterialState.hovered)) {
              return lenraThemeData.lenraBorderThemeData.secondaryHoverBorder;
            }
            return lenraThemeData.lenraBorderThemeData.secondaryBorder;
          }
        }),
        LenraComponentType.Tertiary: (tertiaryBorder != null)
            ? MaterialStateProperty.resolveWith((states) {
                return tertiaryBorder!(
                    states, this.lenraThemeData.lenraColorThemeData);
              })
            : MaterialStateProperty.all(BorderSide.none),
      };

      return map[type] ??
          MaterialStateProperty.all(
              lenraThemeData.lenraBorderThemeData.primaryBorder);
    });

    this.padding =
        LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return lenraThemeData.paddingMap[size] ??
          lenraThemeData.paddingMap[LenraComponentSize.Medium]!;
    });
  }

  ButtonStyle getStyle(LenraComponentType type) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(
          this.lenraThemeData.lenraTextThemeData.bodyText),
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

  LenraButtonThemeData copyWith(LenraButtonThemeData incoming) {
    return LenraButtonThemeData(
      lenraThemeData: this.lenraThemeData,
      primaryBackgroundColor:
          incoming.primaryBackgroundColor ?? this.primaryBackgroundColor,
      secondaryBackgroundColor:
          incoming.secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      tertiaryBackgroundColor:
          incoming.tertiaryBackgroundColor ?? this.tertiaryBackgroundColor,
      primaryForegroundColor:
          incoming.primaryForegroundColor ?? this.primaryForegroundColor,
      secondaryForegroundColor:
          incoming.secondaryForegroundColor ?? this.secondaryForegroundColor,
      tertiaryForegroundColor:
          incoming.tertiaryForegroundColor ?? this.tertiaryForegroundColor,
      primaryBorder: incoming.primaryBorder ?? this.primaryBorder,
      secondaryBorder: incoming.secondaryBorder ?? this.secondaryBorder,
      tertiaryBorder: incoming.tertiaryBorder ?? this.tertiaryBorder,
    );
  }
}
