import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_components.dart';
import '../../lib/component/lenra_toggle.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraToggle test', () {
    LenraToggle component = LenraToggle(value: true, onChanged: (bool _value) {});
    expect(component is LenraToggle, true);
  });

  testWidgets('LenraToggle without label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
      ),
    ));

    expect((tester.widget(find.byType(LenraToggle))) is LenraToggle, true);
    expect((find.byType(Text)), findsNothing);
  });
  testWidgets('LenraToggle with label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
        label: "test",
      ),
    ));

    expect((tester.widget(find.byType(LenraRow)) as LenraRow).children.first is Text, true);
    expect(((tester.widget(find.byType(LenraRow)) as LenraRow).children.elementAt(1)) is Container, true);
  });
  testWidgets('LenraToggle size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
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
        onChanged: (bool _value) {
          value = _value;
        },
      ),
    ));
    expect(value, false);

    await tester.tap(find.byType(LenraToggle));
    await tester.pumpAndSettle();

    expect(value, true);
  });
}
