import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/component/lenra_toggle.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraToggle test', () {
    LenraToggle component = LenraToggle(value: true, onPressed: () {});
    expect(component is LenraToggle, true);
  });

  testWidgets('LenraToggle without label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onPressed: () {},
      ),
    ));

    expect((tester.widget(find.byType(LenraToggle))) is LenraToggle, true);
    expect((find.byType(Text)), findsNothing);
  });
  testWidgets('LenraToggle with label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onPressed: () {},
        label: "test",
      ),
    ));

    expect((tester.widget(find.byType(LenraFlex)) as LenraFlex).children.first is Text, true);
  });
  testWidgets('LenraToggle size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onPressed: () {},
      ),
    ));

    expect((tester.getSize(find.byType(LenraToggle)).width), equals(40));
    expect((tester.getSize(find.byType(LenraToggle)).height), equals(24));
  });

  testWidgets('LenraToggle tap should change the state', (WidgetTester tester) async {
    bool value = false;
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: value,
        onPressed: () {
          value = !value;
        },
      ),
    ));
    expect(value, false);

    await tester.tap(find.byType(LenraToggle));
    await tester.pumpAndSettle();

    expect(value, true);
  });
}
