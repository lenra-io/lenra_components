import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';
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
  LenraTableThemeData lenraTableThemeData;

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
    LenraTableThemeData lenraTableThemeData,
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
    this.lenraTableThemeData = lenraTableThemeData ??
        LenraTableThemeData(
          paddingMap: this.paddingMap,
        );
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
            descriptionStyle: this.lenraTextThemeData.underDescriptionText,
            hintTextStyle: this.lenraTextThemeData.disabledBodyText,
            paddingMap: this.paddingMap.map((key, value) => MapEntry(
                key,
                EdgeInsets.only(
                  top: value.top,
                  bottom: value.bottom,
                  left: baseSize,
                  right: baseSize,
                ))));
  }

  copyWith({
    double baseSize,
    Map<LenraComponentSize, EdgeInsets> paddingMap,
    LenraColorThemeData lenraColorThemeData,
    LenraTextThemeData lenraTextThemeData,
    LenraBorderThemeData lenraBorderThemeData,
    LenraButtonThemeData lenraButtonThemeData,
    LenraRadioThemeData lenraRadioThemeData,
    LenraCheckboxThemeData lenraCheckboxThemeData,
    LenraTextFieldThemeData lenraTextFieldThemeData,
  }) {
    return LenraThemeData(
      baseSize: baseSize ?? this.baseSize,
      paddingMap: paddingMap ?? this.paddingMap,
      lenraColorThemeData: lenraColorThemeData ?? this.lenraColorThemeData,
      lenraTextThemeData: lenraTextThemeData ?? this.lenraTextThemeData,
      lenraBorderThemeData: lenraBorderThemeData ?? this.lenraBorderThemeData,
      lenraButtonThemeData: lenraButtonThemeData ?? this.lenraButtonThemeData,
      lenraRadioThemeData: lenraRadioThemeData ?? this.lenraRadioThemeData,
      lenraCheckboxThemeData: lenraCheckboxThemeData ?? this.lenraCheckboxThemeData,
      lenraTextFieldThemeData: lenraTextFieldThemeData ?? this.lenraTextFieldThemeData,
    );
  }
}
