import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('LenraTextFieldThemeData test', () {
    LenraTextFieldThemeData theme = LenraTextFieldThemeData(
        lenraThemeData: LenraThemeData(), paddingMap: {});
    expect(theme is LenraTextFieldThemeData, true);
  });
}
