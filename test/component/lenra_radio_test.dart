import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_radio.dart';

void main() {
  test('LenraRadio test', () {
    LenraRadio component = LenraRadio(
      value: "truc",
      onPressed: () {},
      groupValue: "truc",
    );
    expect(component is LenraRadio, true);
  });

  test('LenraRadio test disabled', () {
    LenraRadio component = LenraRadio(
      value: "truc",
      onPressed: () {},
      groupValue: "truc",
      disabled: true,
    );
    expect(component is LenraRadio, true);
    expect(component.disabled, true);
  });

  test('LenraRadio test text', () {
    LenraRadio component = LenraRadio(
      value: "truc",
      onPressed: () {},
      groupValue: "truc",
      label: "test",
    );
    expect(component.label, "test");
  });
}
