import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_menu.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  LenraMenu basicMenu = LenraMenu(
    items: [
      LenraMenuItem(text: "test", onPressed: () {}),
      LenraMenuItem(text: "test2", onPressed: () {}),
      LenraMenuItem(text: "test3", isSelected: true, onPressed: () {}),
    ],
  );

  testWidgets('LenraMenu error empty items', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(createAppTestWidgets(LenraMenu(
        items: const [],
      )));
    }, throwsAssertionError);
  });

  testWidgets('LenraMenu two items', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(basicMenu));

    expect((tester.widget(find.byType(LenraMenu)) as LenraMenu).items.length, 3);
  });

  testWidgets('LenraMenuItem should not have Icon if not selected', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraMenu(
        items: [
          LenraMenuItem(
            text: "text",
            onPressed: () => {},
          ),
        ],
      ),
    ));

    expect((find.byType(Icon)), findsNothing);
  });

  testWidgets('LenraMenu check size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(basicMenu));

    double lenraMenuExpectedHeight = 28.0 * basicMenu.items.length + 8 * 2;

    expect(tester.getSize((find.byType(LenraMenu).first)).width, lessThan(800.0));
    expect(tester.getSize((find.byType(LenraMenu).first)).height, equals(lenraMenuExpectedHeight));
  });

  testWidgets('LenraMenuItem check size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(basicMenu));

    // Width should be same as screen if not constrained
    expect(tester.getSize((find.byType(LenraMenuItem).first)).width, lessThan(800.0));
    expect(tester.getSize((find.byType(LenraMenuItem).first)).height, equals(28.0));
  });
}
