import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';

void main() {
  test('lenra text theme data test merge', () {
    final LenraTextThemeData lenraTextThemeDataDefault = LenraTextThemeData();

    final LenraTextThemeData merged = lenraTextThemeDataDefault.copyWith(
        bodyText: const TextStyle(
      color: Colors.red,
      fontFamily: "Source Sans Pro",
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ));

    expect(merged.bodyText.fontFamily, "Source Sans Pro");
    expect(merged.bodyText.fontSize, 14.0);
    expect(merged.bodyText.fontWeight, FontWeight.w400);
    expect(merged.bodyText.color, Colors.red);
  });
}
