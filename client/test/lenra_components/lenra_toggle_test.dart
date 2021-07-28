import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_switch.dart';

void main() {
  test('LenraToggle test', () {
    LenraToggle component =
        LenraToggle(value: true, onChanged: (bool _value) {});
    expect(component is LenraToggle, true);
  });
}
