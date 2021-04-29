import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';

void main() {
  test('LenraTextField test', () {
    LenraTextField component = LenraTextField();
    expect(component is LenraTextField, true);
  });

  test('LenraTextField getValue test', () {
    LenraTextField component = LenraTextField();
    var componentState = component.createState();
    componentState.initState();
    expect(componentState.getValue(), "");
    componentState.value = "test";
    expect(componentState.getValue(), "test");
  });
}
