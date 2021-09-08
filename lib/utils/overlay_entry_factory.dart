import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class OverlayEntryFactory {
  static OverlayEntry withTheme({required BuildContext context, required Widget child}) {
    LenraThemeData lenraThemeData = LenraTheme.of(context);
    return OverlayEntry(
      builder: (context) => LenraTheme(
        themeData: lenraThemeData,
        child: child,
      ),
    );
  }
}
