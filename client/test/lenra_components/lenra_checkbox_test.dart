import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_checkbox.dart';

void main() {
  test('lenra checkbox test parameterized constructor', () {
    LenraCheckbox lenraCheckbox = LenraCheckbox(
      label: "test",
      onChanged: () {},
      value: true,
      disabled: true,
    );

    expect(lenraCheckbox.disabled, true);
    expect(lenraCheckbox.label, "test");
    expect(lenraCheckbox.value, true);
  });
}
