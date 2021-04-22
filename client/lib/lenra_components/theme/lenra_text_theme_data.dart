import 'package:flutter/material.dart';

class LenraTextThemeData {
  TextStyle headline1;
  TextStyle headline2;
  TextStyle headline3;
  TextStyle headline4;
  TextStyle headlineBody;
  TextStyle bodyText;
  TextStyle subtext;

  LenraTextThemeData({
    TextStyle headline1,
    TextStyle headline2,
    TextStyle headline3,
    TextStyle headline4,
    TextStyle headlineBody,
    TextStyle bodyText,
    TextStyle subtext,
  }) {
    this.headline1 = headline1 ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        );
    this.headline2 = headline2 ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        );
    this.headline3 = headline3 ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        );
    this.headline4 = headline4 ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        );
    this.headlineBody = headlineBody ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        );
    this.bodyText = bodyText ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        );
    this.subtext = subtext ??
        TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        );
  }

  LenraTextThemeData merge(LenraTextThemeData incoming) {
    if (incoming != null) {
      return LenraTextThemeData(
        headline1: this.headline1.merge(incoming.headline1),
        headline2: this.headline2.merge(incoming.headline2),
        headline3: this.headline3.merge(incoming.headline3),
        headline4: this.headline4.merge(incoming.headline4),
        headlineBody: this.headlineBody.merge(incoming.headlineBody),
        bodyText: this.bodyText.merge(incoming.bodyText),
        subtext: this.subtext.merge(incoming.subtext),
      );
    }

    return this;
  }
}
