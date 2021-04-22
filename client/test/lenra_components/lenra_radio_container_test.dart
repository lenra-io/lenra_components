import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio_container.dart';

void main() {
  test('LenraRadioContainer test', () {
    LenraRadioContainer component = LenraRadioContainer();
    expect(component is LenraRadioContainer, true);
  });

  test('LenraRadioContainer access function', () {
    LenraRadioContainer component = LenraRadioContainer();
    var componentState = component.createState();
    componentState.initState();
    expect(componentState.getValue(), null);
    componentState.onValueChanged(2);
    expect(componentState.getValue(), 2);
  });
}
