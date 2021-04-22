import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('lenra theme data test default constructor', () {
    LenraThemeData lenraThemeData = LenraThemeData();

    expect(lenraThemeData.lenraBorderThemeData != null, true);
    expect(lenraThemeData.lenraColorThemeData != null, true);
    expect(lenraThemeData.lenraButtonThemeData != null, true);
    expect(lenraThemeData.lenraTextThemeData != null, true);
  });
}
