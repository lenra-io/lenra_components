import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

void main() {
  test('lenra text theme data test merge', () {
    LenraTextThemeData lenraTextThemeDataDefault = LenraTextThemeData();
    LenraTextThemeData lenraTextThemeDataModified = LenraTextThemeData(bodyText: TextStyle(color: Colors.red));

    LenraTextThemeData merged = lenraTextThemeDataDefault.merge(lenraTextThemeDataModified);

    expect(merged.bodyText.fontFamily, "Source Sans Pro");
    expect(merged.bodyText.fontSize, 14.0);
    expect(merged.bodyText.fontWeight, FontWeight.w400);
    expect(merged.bodyText.color, Colors.red);
  });
}
