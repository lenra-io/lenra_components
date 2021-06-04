import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio.dart';

void main() {
  test('LenraRadio test', () {
    LenraRadio component = LenraRadio();
    expect(component is LenraRadio, true);
  });

  test('LenraRadio test disabled', () {
    LenraRadio component = LenraRadio(
      disabled: true,
    );
    expect(component is LenraRadio, true);
    expect(component.disabled, true);
  });

  // Color set in LenrathemeData
  //test('LenraRadio test color', () {
  //  LenraRadio component = LenraRadio(
  //    lenraRadioThemeData: LenraRadioThemeData(
  //        colorTheme: LenraColorThemeData(
  //            primaryBackgroundDisabledColor: Colors.red[100], secondaryForegroundDisabledColor: Colors.red[100])),
  //  );
  //  expect(component is LenraRadio, true);
  //  expect(component.lenraRadioThemeData.colorTheme.primaryBackgroundDisabledColor, Colors.red[100]);
  //  expect(component.lenraRadioThemeData.colorTheme.secondaryForegroundDisabledColor, Colors.red[100]);
  //});

  test('LenraRadio test text', () {
    LenraRadio component = LenraRadio(
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
