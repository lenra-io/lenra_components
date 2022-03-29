import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

class LenraTextThemeData {
  static const double defaultBaseFontSize = 15;
  static const double baseLineHeight = 20;
  late TextStyle headline1;
  late TextStyle headline2;
  late TextStyle headline3;
  late TextStyle headline4;
  late TextStyle headlineBody;
  late TextStyle bodyText;
  late TextStyle blueBodyText;
  late TextStyle subtext;
  late TextStyle disabledBodyText;
  late TextStyle underDescriptionText;
  late TextStyle errorText;

  late LenraThemePropertyMapper<TextStyle, LenraTextStyle> textStyle;

  final double? lineHeight;

  LenraTextThemeData({
    this.lineHeight = baseLineHeight / defaultBaseFontSize,
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headlineBody,
    TextStyle? bodyText,
    TextStyle? blueBodyText,
    TextStyle? subtext,
    TextStyle? disabledBodyText,
    TextStyle? underDescriptionText,
    TextStyle? errorText,
  }) {
    this.headline1 = headline1 ??
        TextStyle(
          fontSize: defaultBaseFontSize * 5 / 3,
          fontWeight: FontWeight.w700,
          height: lineHeight,
        );
    this.headline2 = headline2 ??
        TextStyle(
          fontSize: defaultBaseFontSize * 4 / 3,
          fontWeight: FontWeight.w700,
          height: lineHeight,
        );
    this.headline3 = headline3 ??
        TextStyle(
          fontSize: defaultBaseFontSize * 6 / 5,
          fontWeight: FontWeight.w700,
          height: lineHeight,
        );
    this.headline4 = headline4 ??
        TextStyle(
          fontSize: defaultBaseFontSize,
          fontWeight: FontWeight.w700,
          height: lineHeight,
        );
    this.headlineBody = headlineBody ??
        TextStyle(
          fontSize: defaultBaseFontSize,
          fontWeight: FontWeight.w600,
          height: lineHeight,
        );
    this.bodyText = bodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: defaultBaseFontSize,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.lenraBlack,
          height: lineHeight,
        );
    this.blueBodyText = bodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: defaultBaseFontSize,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.lenraBlue,
          height: lineHeight,
        );
    this.subtext = subtext ??
        TextStyle(
          fontSize: defaultBaseFontSize * 4 / 5,
          height: lineHeight,
        );
    this.disabledBodyText = disabledBodyText ??
        TextStyle(
          color: LenraColorThemeData.lenraDisabledGray,
          height: lineHeight,
        );

    this.underDescriptionText = underDescriptionText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: defaultBaseFontSize * 4 / 5,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.lenraGreyText,
          height: lineHeight,
        );
    this.errorText = disabledBodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: defaultBaseFontSize,
          fontWeight: FontWeight.w400,
          color: Colors.red,
          height: lineHeight,
        );

    textStyle = LenraThemePropertyMapper.resolveWith((LenraTextStyle lenraTextStyle) {
      switch (lenraTextStyle) {
        case LenraTextStyle.headline1:
          return this.headline1;
        case LenraTextStyle.headline2:
          return this.headline2;
        case LenraTextStyle.headline3:
          return this.headline3;
        case LenraTextStyle.headline4:
          return this.headline4;
        case LenraTextStyle.headlineBody:
          return this.headlineBody;
        case LenraTextStyle.bodyText:
          return this.bodyText;
        case LenraTextStyle.blueBodyText:
          return this.blueBodyText;
        case LenraTextStyle.subtext:
          return this.subtext;
        case LenraTextStyle.disabledBodyText:
          return this.disabledBodyText;
        case LenraTextStyle.underDescriptionText:
          return this.underDescriptionText;
        case LenraTextStyle.errorText:
          return this.errorText;
        default:
          return this.bodyText;
      }
    });
  }

  TextStyle getStyle(LenraTextStyle lenraTextStyle) {
    return textStyle.resolve(lenraTextStyle);
  }

  LenraTextThemeData copyWith({
    double? lineHeight,
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headlineBody,
    TextStyle? bodyText,
    TextStyle? subtext,
    TextStyle? disabledBodyText,
  }) {
    return LenraTextThemeData(
      lineHeight: lineHeight ?? this.lineHeight,
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline4: headline4 ?? this.headline4,
      headlineBody: headlineBody ?? this.headlineBody,
      bodyText: bodyText ?? this.bodyText,
      subtext: subtext ?? this.subtext,
      disabledBodyText: disabledBodyText ?? this.disabledBodyText,
    );
  }
}
