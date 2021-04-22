import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_checkbox.dart';

void main() {
  test('lenra checkbox test parameterized constructor', () {
    LenraCheckbox lenraCheckbox = LenraCheckbox(
      text: "test",
      value: true,
      disabled: true,
    );

    expect(lenraCheckbox.disabled, true);
    expect(lenraCheckbox.text, "test");
    expect(lenraCheckbox.value, true);
  });
}
