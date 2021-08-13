import 'package:flutter/cupertino.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraCheckboxThemeData {
  final LenraThemeData lenraThemeData;
  final Function(bool, LenraTextThemeData)? textStyle;

  LenraCheckboxThemeData({
    required this.lenraThemeData,
    this.textStyle,
  });
  TextStyle getTextStyle(bool disabled) {
    if (textStyle != null) {
      return textStyle!(disabled, this.lenraThemeData.lenraTextThemeData);
    } else {
      return disabled
          ? lenraThemeData.lenraTextThemeData.disabledBodyText
          : lenraThemeData.lenraTextThemeData.bodyText;
    }
  }

  LenraCheckboxThemeData copyWith(LenraCheckboxThemeData incoming) {
    return LenraCheckboxThemeData(
        lenraThemeData: this.lenraThemeData,
        textStyle: incoming.textStyle ?? this.textStyle);
  }
}
