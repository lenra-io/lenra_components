import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';

void main() {
  test('lenra button theme data test merge', () {
    LenraButtonThemeData lenraButtonThemeDataDefault = LenraButtonThemeData();
    LenraButtonThemeData lenraButtonThemeDataModified = LenraButtonThemeData(type: LenraButtonType.Secondary);

    LenraButtonThemeData merged = lenraButtonThemeDataDefault.merge(lenraButtonThemeDataModified);

    expect(merged.minimumSize != lenraButtonThemeDataDefault.minimumSize, true);
  });
}
