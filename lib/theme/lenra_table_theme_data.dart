import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_property_mapper.dart';

class LenraTableThemeData {
  final LenraThemeData lenraThemeData;
  final Color? borderColor;
  final Color? backgroundColor;
  late LenraThemePropertyMapper<dynamic, LenraComponentSize> padding;

  LenraTableThemeData({
    required this.lenraThemeData,
    this.backgroundColor,
    this.borderColor,
  }) {
    this.padding =
        LenraThemePropertyMapper.resolveWith((LenraComponentSize size) {
      return lenraThemeData.paddingMap[size] ??
          lenraThemeData.paddingMap[LenraComponentSize.Medium]!;
    });
  }

  EdgeInsets getPadding(LenraComponentSize size) {
    return this.padding.resolve(size);
  }

  Color getBorderColor() {
    return backgroundColor ??
        lenraThemeData.lenraBorderThemeData.primaryBorder.color;
  }

  BoxDecoration getBoxDecoration(bool header) {
    return BoxDecoration(
      color: header
          ? borderColor ??
              lenraThemeData.lenraColorThemeData.primaryBackgroundColor
          : Colors.transparent,
    );
  }

  LenraTableThemeData copyWith(LenraTableThemeData incoming) {
    return LenraTableThemeData(
      lenraThemeData: this.lenraThemeData,
      borderColor: incoming.borderColor ?? this.borderColor,
      backgroundColor: incoming.backgroundColor ?? this.backgroundColor,
    );
  }
}
