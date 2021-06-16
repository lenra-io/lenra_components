import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraTableThemeData {
  LenraThemeData lenraTheme;
  late LenraThemePropertyMapper<EdgeInsetsGeometry, LenraComponentSize> padding;
  LenraTableThemeData({
    required this.lenraTheme,
  }) {
    this.padding = LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return lenraTheme.paddingMap[size] ?? lenraTheme.paddingMap[LenraComponentSize.Medium]!;
    });
  }

  EdgeInsetsGeometry getPadding(LenraComponentSize size) {
    return this.padding.resolve(size);
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
