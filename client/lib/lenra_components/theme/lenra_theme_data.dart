import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

class LenraThemeData {
  final double baseSize;
  LenraColorThemeData lenraColorThemeData;
  LenraTextThemeData lenraTextThemeData;
  LenraBorderThemeData lenraBorderThemeData;
  LenraButtonThemeData lenraButtonThemeData;
  LenraRadioThemeData lenraRadioThemeData;
  LenraCheckboxThemeData lenraCheckboxThemeData;
  LenraTextFieldThemeData lenraTextFieldThemeData;

  LenraThemeData({
    this.baseSize = 8,
    LenraColorThemeData lenraColorThemeData,
    LenraTextThemeData lenraTextThemeData,
    LenraBorderThemeData lenraBorderThemeData,
    LenraButtonThemeData lenraButtonThemeData,
    LenraRadioThemeData lenraRadioThemeData,
    LenraCheckboxThemeData lenraCheckboxThemeData,
    LenraTextFieldThemeData lenraTextFieldThemeData,
  }) {
    this.lenraColorThemeData = lenraColorThemeData ?? LenraColorThemeData();
    this.lenraTextThemeData = lenraTextThemeData ?? LenraTextThemeData();
    this.lenraBorderThemeData = lenraBorderThemeData ?? LenraBorderThemeData();
    this.lenraButtonThemeData = lenraButtonThemeData ??
        LenraButtonThemeData(
          colorTheme: this.lenraColorThemeData,
          textStyle: this.lenraTextThemeData.bodyText,
          border: this.lenraBorderThemeData,
        );
    this.lenraRadioThemeData = lenraRadioThemeData ??
        LenraRadioThemeData(
          border: this.lenraBorderThemeData,
        );
    this.lenraCheckboxThemeData = lenraCheckboxThemeData ??
        LenraCheckboxThemeData(
          lenraTextThemeData: this.lenraTextThemeData,
        );
    this.lenraTextFieldThemeData = lenraTextFieldThemeData ?? LenraTextFieldThemeData();
  }
}
