import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('lenra theme test parameterized constructor', () {
    Text text = Text("test");

    LenraTheme lenraTheme = LenraTheme(
      themeData: LenraThemeData(),
      child: text,
    );

    expect(lenraTheme.child, text);
  });
}
