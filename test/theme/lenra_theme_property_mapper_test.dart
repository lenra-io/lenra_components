import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/theme/lenra_theme_property_mapper.dart';

void main() {
  test('lenra theme property mapper test resolve', () {
    LenraThemePropertyMapper<String, String> stringAll = LenraThemePropertyMapper.all("test");
    LenraThemePropertyMapper<String, String> stringResolve =
        LenraThemePropertyMapper.resolveWith((String test) => test);

    expect(stringAll.resolve("test"), "test");
    expect(stringResolve.resolve("test"), "test");
  });
}
