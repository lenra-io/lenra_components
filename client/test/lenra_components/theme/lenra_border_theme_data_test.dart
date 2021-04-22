import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_border_theme_data.dart';

void main() {
  test('lenra border theme data test merge', () {
    LenraBorderThemeData lenraBorderThemeData = LenraBorderThemeData();
    LenraBorderThemeData lenraBorderThemeDataModified =
        LenraBorderThemeData(primaryBorder: BorderSide(color: Colors.red));

    LenraBorderThemeData merged = lenraBorderThemeData.merge(lenraBorderThemeDataModified);

    expect(merged.primaryBorder != lenraBorderThemeData.primaryBorder, true);
  });
}
