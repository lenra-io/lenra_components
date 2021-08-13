import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraTheme extends StatelessWidget {
  final LenraThemeData themeData;
  final Widget child;

  const LenraTheme({
    Key? key,
    required this.themeData,
    required this.child,
  }) : super(key: key);

  static LenraThemeData of(BuildContext context) {
    final LenraThemeData? lenraThemeData =
        context.dependOnInheritedWidgetOfExactType<_LenraInheritedTheme>()?.theme.themeData;
    assert(lenraThemeData != null, 'No LenraTheme found in context');
    return lenraThemeData!;
  }

  @override
  Widget build(BuildContext context) {
    return _LenraInheritedTheme(
      theme: this,
      child: DefaultTextStyle(
        style: themeData.lenraTextThemeData.bodyText,
        child: child,
      ),
    );
  }
}

class _LenraInheritedTheme extends InheritedTheme {
  const _LenraInheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final LenraTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return LenraTheme(themeData: theme.themeData, child: child);
  }

  @override
  bool updateShouldNotify(_LenraInheritedTheme old) => theme.themeData != old.theme.themeData;
}
