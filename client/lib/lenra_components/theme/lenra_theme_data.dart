import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

enum LenraComponentSize {
  Small,
  Medium,
  Large,
}

class LenraThemeData {
  final double baseSize;
  Map<LenraComponentSize, EdgeInsets> paddingMap;
  LenraColorThemeData lenraColorThemeData;
  LenraTextThemeData lenraTextThemeData;
  LenraBorderThemeData lenraBorderThemeData;
  LenraButtonThemeData lenraButtonThemeData;
  LenraRadioThemeData lenraRadioThemeData;
  LenraCheckboxThemeData lenraCheckboxThemeData;
  LenraTextFieldThemeData lenraTextFieldThemeData;

  LenraThemeData({
    this.baseSize = 8,
    Map<LenraComponentSize, EdgeInsets> paddingMap,
    LenraColorThemeData lenraColorThemeData,
    LenraTextThemeData lenraTextThemeData,
    LenraBorderThemeData lenraBorderThemeData,
    LenraButtonThemeData lenraButtonThemeData,
    LenraRadioThemeData lenraRadioThemeData,
    LenraCheckboxThemeData lenraCheckboxThemeData,
    LenraTextFieldThemeData lenraTextFieldThemeData,
  }) {
    this.paddingMap = paddingMap ??
        {
          LenraComponentSize.Small: EdgeInsets.symmetric(vertical: 0.5 * baseSize, horizontal: 2 * baseSize),
          LenraComponentSize.Medium: EdgeInsets.symmetric(vertical: 1 * baseSize, horizontal: 2 * baseSize),
          LenraComponentSize.Large: EdgeInsets.symmetric(vertical: 1.5 * baseSize, horizontal: 2 * baseSize),
        };
    this.lenraColorThemeData = lenraColorThemeData ?? LenraColorThemeData();
    this.lenraTextThemeData = lenraTextThemeData ?? LenraTextThemeData();
    this.lenraBorderThemeData = lenraBorderThemeData ?? LenraBorderThemeData();
    this.lenraButtonThemeData = lenraButtonThemeData ??
        LenraButtonThemeData(
          colorTheme: this.lenraColorThemeData,
          textStyle: this.lenraTextThemeData.bodyText,
          border: this.lenraBorderThemeData,
          paddingMap: this.paddingMap,
        );
    this.lenraRadioThemeData = lenraRadioThemeData ??
        LenraRadioThemeData(
          border: this.lenraBorderThemeData,
        );
    this.lenraCheckboxThemeData = lenraCheckboxThemeData ??
        LenraCheckboxThemeData(
          lenraTextThemeData: this.lenraTextThemeData,
        );
    this.lenraTextFieldThemeData = lenraTextFieldThemeData ??
        LenraTextFieldThemeData(
            textStyle: this.lenraTextThemeData.bodyText,
            paddingMap: this.paddingMap.map((key, value) => MapEntry(
                key,
                EdgeInsets.only(
                  top: value.top,
                  bottom: value.bottom,
                  left: baseSize,
                  right: baseSize,
                ))));
  }
}
