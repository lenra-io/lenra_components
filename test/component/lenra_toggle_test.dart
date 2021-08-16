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

    expect((tester.widget(find.byType(Switch))) is Switch, true);
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

    expect((tester.widget(find.byType(LenraRow)) as LenraRow).children.first is Text, true);
    expect(
        ((tester.widget(find.byType(LenraRow)) as LenraRow).children.elementAt(1) as SizedBox).child is Switch, true);
  });
  testWidgets('LenraToggle size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraToggle(
        value: true,
        onChanged: (bool _value) {},
      ),
    ));

    //expect((tester.getSize(find.byType(Switch)).width), equals(44));
    expect((tester.getSize(find.byType(Switch)).height), equals(24));
  });
}
