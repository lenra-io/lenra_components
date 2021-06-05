import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

Widget createBaseTestWidgets(Widget child) {
  return LenraTheme(
    themeData: LenraThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: child,
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
