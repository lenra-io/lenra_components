import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

void main() {
  test('lenra button theme data test merge', () {
    LenraCheckboxThemeData lenraCheckboxThemeDataDefault = LenraCheckboxThemeData();
    LenraCheckboxThemeData lenraCheckboxThemeDataModified = LenraCheckboxThemeData(
      lenraTextThemeData: LenraTextThemeData(
        bodyText: TextStyle(color: Colors.red),
      ),
    );

    LenraCheckboxThemeData merged = lenraCheckboxThemeDataDefault.merge(lenraCheckboxThemeDataModified);

    expect(merged.lenraTextThemeData != lenraCheckboxThemeDataDefault.lenraTextThemeData, true);
  });
}
