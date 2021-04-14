import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraTheme extends InheritedWidget {
  final LenraThemeData themeData;

  const LenraTheme({
    Key key,
    this.themeData,
    Widget child,
  }) : super(key: key, child: child);

  static LenraThemeData of(BuildContext context) {
    final LenraThemeData lenraThemeData =
        context.dependOnInheritedWidgetOfExactType<LenraTheme>()?.themeData;
    assert(lenraThemeData != null, 'No LenraTheme found in context');
    return lenraThemeData;
  }

  @override
  bool updateShouldNotify(LenraTheme oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
