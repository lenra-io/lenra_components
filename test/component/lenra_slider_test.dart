import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_slider.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('Test LenraSlider', (WidgetTester tester) async {
    double value = 0.0;

    await tester.pumpWidget(createComponentTestWidgets(
      LenraSlider(
        value: value,
        onChanged: (double? v) {
          expect(v, 0.5);
        },
      ),
    ));

    Slider slider = tester.widget(find.byType(Slider));
    expect(slider.max, 1.0);
    expect(slider.min, 0.0);
    expect(slider.value, 0.0);

    await tester.tap(find.byType(Slider));
  });

  testWidgets('Test LenraSlider properties are properly passed to Slider', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraSlider(
        divisions: 5,
        label: "Foo",
      ),
    ));

    Slider slider = tester.widget(find.byType(Slider));
    expect(slider.divisions, 5);
    expect(slider.label, "Foo");
    expect(slider.autofocus, false);
  });
}
