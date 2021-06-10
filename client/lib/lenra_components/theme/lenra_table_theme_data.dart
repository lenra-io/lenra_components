import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraTableThemeData {
  LenraThemeData lenraTheme;
  LenraTableThemeData({
    this.lenraTheme,
  });

  EdgeInsets getPadding(LenraComponentSize size) {
    return lenraTheme.paddingMap[size] ?? lenraTheme.paddingMap[LenraComponentSize.Medium];
  }

  Color getBorderColor() {
    return lenraTheme.lenraBorderThemeData.primaryBorder.color;
  }

  BoxDecoration getBoxDecoration(bool header) {
    return BoxDecoration(
      color: header ? lenraTheme.lenraColorThemeData.primaryBackgroundColor : Colors.transparent,
    );
  }
}
