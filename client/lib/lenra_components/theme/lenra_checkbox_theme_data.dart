import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraCheckboxThemeData {
  LenraThemeData lenraTheme;

  LenraCheckboxThemeData({
    required this.lenraTheme,
  });
  TextStyle getTextStyle(bool disabled) {
    return disabled ? lenraTheme.lenraTextThemeData.disabledBodyText : lenraTheme.lenraTextThemeData.bodyText;
  }
}
