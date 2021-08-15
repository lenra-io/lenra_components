import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

class LenraTextThemeData {
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

  final double? lineHeight;

  LenraTextThemeData({
    this.lineHeight = 14 / 15,
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
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        );
    this.headline2 = headline2 ??
        TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        );
    this.headline3 = headline3 ??
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        );
    this.headline4 = headline4 ??
        TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
        );
    this.headlineBody = headlineBody ??
        TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        );
    this.bodyText = bodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.LENRA_BLACK,
          height: lineHeight,
        );
    this.blueBodyText = bodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.LENRA_BLUE,
          height: lineHeight,
        );
    this.subtext = subtext ??
        TextStyle(
          fontSize: 12.0,
        );
    this.disabledBodyText = disabledBodyText ??
        TextStyle(
          color: LenraColorThemeData.LENRA_DISABLED_GRAY,
        );

    this.underDescriptionText = underDescriptionText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: LenraColorThemeData.LENRA_GREY_TEXT,
          height: lineHeight,
        );
    this.errorText = disabledBodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.red,
          height: lineHeight,
        );
  }

  copyWith({
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
