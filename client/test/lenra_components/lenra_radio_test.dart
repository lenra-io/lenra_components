import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio.dart';

void main() {
  test('LenraRadio test', () {
    LenraRadio component = LenraRadio(
      value: "",
      onChanged: (T) {},
      groupValue: "",
    );
    expect(component is LenraRadio, true);
  });

  test('LenraRadio test disabled', () {
    LenraRadio component = LenraRadio(
      value: "",
      onChanged: (T) {},
      groupValue: "",
      disabled: true,
    );
    expect(component is LenraRadio, true);
    expect(component.disabled, true);
  });

  test('LenraRadio test text', () {
    LenraRadio component = LenraRadio(
      value: "",
      onChanged: (T) {},
      groupValue: "",
      label: "test",
    );
    expect(component.label, "test");
  });

  // test('LenraRadio test State func', () {
  //   int _selected;
  //   int getChanged() {
  //     return _selected;
  //   }

  //   void onChanged(value) {
  //     _selected = value;
  //   }

  //   bool update() {
  //     return true;
  //   }

  //   LenraRadio component = LenraRadio();
  //   var componentState = component.createState();
  //   componentState.initState();
  //   expect(componentState.getChanged(), null);
  //   componentState.onChanged(1);
  //   expect(componentState.getChanged(), 1);
  //   expect(componentState.update(), true);
  // });
}
