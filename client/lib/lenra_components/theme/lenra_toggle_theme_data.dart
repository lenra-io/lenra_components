import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraToggleThemeData {
  final LenraThemeData lenraThemeData;
  final Function(bool, LenraColorThemeData)? activeColor;
  LenraToggleThemeData({
    required this.lenraThemeData,
    this.activeColor,
  });
  Color get_activeColor(bool disabled) {
    if (activeColor != null) {
      return this.activeColor!(disabled, lenraThemeData.lenraColorThemeData);
    } else if (disabled) {
      return LenraColorThemeData.LENRA_DISABLED_GRAY;
    } else {
      return LenraColorThemeData.LENRA_WHITE;
    }
  }
}
