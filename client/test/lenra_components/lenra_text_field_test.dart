import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';

void main() {
  test('LenraTextField test', () {
    LenraTextField component = LenraTextField();
    expect(component is LenraTextField, true);
  });
}
