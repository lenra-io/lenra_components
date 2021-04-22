import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

void main() {
  test('lenra color theme data test default constructor', () {
    LenraColorThemeData lenraColorThemeDataDefault = LenraColorThemeData();
    LenraColorThemeData lenraColorThemeData = LenraColorThemeData(primaryBackgroundColor: Colors.red);

    expect(lenraColorThemeDataDefault.primaryBackgroundColor, LenraColorThemeData.LENRA_BLUE);
    expect(lenraColorThemeData.primaryBackgroundColor, Colors.red);
  });
}
