import 'package:flutter/cupertino.dart';
import 'package:lenra_components/theme/lenra_border_theme_data.dart';
import 'package:lenra_components/theme/lenra_button_theme_data.dart';
import 'package:lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_menu_theme_data.dart';
import 'package:lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:lenra_components/theme/lenra_table_theme_data.dart';
import 'package:lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';

enum LenraComponentSize {
  small,
  medium,
  large,
}

enum LenraComponentType {
  primary,
  secondary,
  tertiary,
}

enum LenraTextType {
  headline1,
  headline2,
  headline3,
  headline4,
  headlineBody,
  bodyText,
  blueBodyText,
  subtext,
  disabledBodyText,
  underDescriptionText,
  errorText,
}

class LenraThemeData {
  final double baseSize;
  late Map<LenraComponentSize, EdgeInsets> paddingMap;
  late LenraColorThemeData lenraColorThemeData;
  late LenraTextThemeData lenraTextThemeData;
  late LenraBorderThemeData lenraBorderThemeData;
  late LenraButtonThemeData lenraButtonThemeData;
  late LenraRadioThemeData lenraRadioThemeData;
  late LenraCheckboxThemeData lenraCheckboxThemeData;
  late LenraTextFieldThemeData lenraTextFieldThemeData;
  late LenraTableThemeData lenraTableThemeData;
  late LenraMenuThemeData lenraMenuThemeData;

  LenraThemeData({
    this.baseSize = 8,
    Map<LenraComponentSize, EdgeInsets>? paddingMap,
    LenraColorThemeData? lenraColorThemeData,
    LenraTextThemeData? lenraTextThemeData,
    LenraBorderThemeData? lenraBorderThemeData,
    LenraButtonThemeData? lenraButtonThemeData,
    LenraRadioThemeData? lenraRadioThemeData,
    LenraCheckboxThemeData? lenraCheckboxThemeData,
    LenraTextFieldThemeData? lenraTextFieldThemeData,
    LenraTableThemeData? lenraTableThemeData,
    LenraMenuThemeData? lenraMenuThemeData,
  }) {
    this.paddingMap = paddingMap ??
        {
          LenraComponentSize.small: EdgeInsets.symmetric(vertical: 0.5 * baseSize, horizontal: 2 * baseSize),
          LenraComponentSize.medium: EdgeInsets.symmetric(vertical: 1 * baseSize, horizontal: 2 * baseSize),
          LenraComponentSize.large: EdgeInsets.symmetric(vertical: 1.5 * baseSize, horizontal: 2 * baseSize),
        };
    this.lenraColorThemeData = lenraColorThemeData ?? LenraColorThemeData();
    this.lenraTextThemeData = lenraTextThemeData ?? LenraTextThemeData();
    this.lenraBorderThemeData = lenraBorderThemeData ?? LenraBorderThemeData();
    this.lenraTableThemeData = LenraTableThemeData(
      lenraThemeData: this,
    );
    this.lenraButtonThemeData = LenraButtonThemeData(
      lenraThemeData: this,
    );
    this.lenraRadioThemeData = LenraRadioThemeData(
      lenraThemeData: this,
    );
    this.lenraCheckboxThemeData = LenraCheckboxThemeData(
      lenraThemeData: this,
    );
    this.lenraTextFieldThemeData = LenraTextFieldThemeData(
      lenraThemeData: this,
      paddingMap: this.paddingMap.map((key, value) => MapEntry(
          key,
          EdgeInsets.only(
            top: value.top,
            bottom: value.bottom,
            left: baseSize,
            right: baseSize,
          ))),
    );
    this.lenraMenuThemeData = LenraMenuThemeData(
      lenraThemeData: this,
    );
  }

  copyWith({
    double? baseSize,
    Map<LenraComponentSize, EdgeInsets>? paddingMap,
    LenraColorThemeData? lenraColorThemeData,
    LenraTextThemeData? lenraTextThemeData,
    LenraBorderThemeData? lenraBorderThemeData,
    LenraButtonThemeData? lenraButtonThemeData,
    LenraRadioThemeData? lenraRadioThemeData,
    LenraCheckboxThemeData? lenraCheckboxThemeData,
    LenraTextFieldThemeData? lenraTextFieldThemeData,
    LenraMenuThemeData? lenraMenuThemeData,
  }) {
    return LenraThemeData(
      baseSize: baseSize ?? this.baseSize,
      paddingMap: paddingMap ?? this.paddingMap,
      lenraTextThemeData: lenraTextThemeData ?? this.lenraTextThemeData,
      lenraBorderThemeData: lenraBorderThemeData ?? this.lenraBorderThemeData,
      lenraButtonThemeData: lenraButtonThemeData ?? this.lenraButtonThemeData,
      lenraRadioThemeData: lenraRadioThemeData ?? this.lenraRadioThemeData,
      lenraCheckboxThemeData: lenraCheckboxThemeData ?? this.lenraCheckboxThemeData,
      lenraTextFieldThemeData: lenraTextFieldThemeData ?? this.lenraTextFieldThemeData,
      lenraMenuThemeData: lenraMenuThemeData ?? this.lenraMenuThemeData,
    );
  }
}
