import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';

void main() {
  test('LenraRadioThemeData test', () {
    LenraRadioThemeData theme = LenraRadioThemeData();
    expect(theme is LenraRadioThemeData, true);
  });

  test('LenraRadioThemeData test merge', () {
    LenraRadioThemeData theme = LenraRadioThemeData();
    theme.merge(LenraRadioThemeData(colorTheme: LenraColorThemeData(primaryBackgroundColor: Color(0xff1269ed))));
    expect(theme.colorTheme.primaryBackgroundColor, Color(0xff1269ed));
  });
}
