import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/lenra_toggle.dart';

import '../page/lenra_page_test_help.dart';

void main() {
  test('LenraToggle test', () {
    LenraToggle component =
        LenraToggle(value: true, onChanged: (bool _value) {});
    expect(component is LenraToggle, true);
  });

  testWidgets('LenraToggle without label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
      ),
    ));

    expect(
        (tester.widget(find.byType(CupertinoSwitch))) is CupertinoSwitch, true);
    expect((find.byType(LenraRow)), findsNothing);
  });
  testWidgets('LenraToggle with label', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
        label: "test",
      ),
    ));

    expect(
        (tester.widget(find.byType(LenraRow)) as LenraRow).children.first
            is Text,
        true);
    expect(
        (tester.widget(find.byType(LenraRow)) as LenraRow).children.elementAt(1)
            is CupertinoSwitch,
        true);
  });
}
