import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('lenra theme data test default constructor', () {
    LenraThemeData lenraThemeData = LenraThemeData();

    expect(lenraThemeData.lenraBorderThemeData, isNotNull);
    expect(lenraThemeData.lenraColorThemeData, isNotNull);
    expect(lenraThemeData.lenraButtonThemeData, isNotNull);
    expect(lenraThemeData.lenraTextThemeData, isNotNull);
  });
}
