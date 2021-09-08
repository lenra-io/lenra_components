import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

Widget createBaseTestWidgets(Widget child) {
  return MaterialApp(
    home: LenraTheme(
      themeData: LenraThemeData(),
      child: Scaffold(
        body: child,
      ),
    ),
  );
}

Widget createAppTestWidgets(Widget child) {
  return createBaseTestWidgets(
    MaterialApp(home: child),
  );
}

Widget createComponentTestWidgets(Widget child) {
  return createBaseTestWidgets(
    MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    ),
  );
}
