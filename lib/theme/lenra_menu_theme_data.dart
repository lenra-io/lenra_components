import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraMenuThemeData {
  final LenraThemeData lenraThemeData;
  TextStyle? menuText;

  LenraMenuThemeData({
    required this.lenraThemeData,
    TextStyle? menuText,
  }) {
    this.menuText = menuText ??
        lenraThemeData.lenraTextThemeData.bodyText.copyWith(
          color: LenraColorThemeData.LENRA_WHITE,
        );
  }

  LenraMenuThemeData copyWith(LenraMenuThemeData incoming) {
    return LenraMenuThemeData(
      lenraThemeData: lenraThemeData,
      menuText: incoming.menuText ?? menuText,
    );
  }
}
