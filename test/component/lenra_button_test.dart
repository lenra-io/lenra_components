import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('lenra button test parameterized constructor', () {
    LenraButton lenraButton = LenraButton(
      disabled: true,
      text: "disabled",
      size: LenraComponentSize.large,
      type: LenraComponentType.secondary,
      leftIcon: null,
      rightIcon: null,
      onPressed: () {},
    );

    expect(lenraButton.disabled, true);
    expect(lenraButton.text, "disabled");
    expect(lenraButton.size, LenraComponentSize.large);
    expect(lenraButton.type, LenraComponentType.secondary);
    expect(lenraButton.leftIcon, null);
    expect(lenraButton.rightIcon, null);
  });

  testWidgets('Test LenraButton Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.small,
        onPressed: () {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(24.0));
  });

  testWidgets('Test LenraButton Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.medium,
        onPressed: () {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(32.0));
  });

  testWidgets('Test LenraButton Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.large,
        onPressed: () {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(40.0));
  });

  testWidgets('LenraButton test rightIcon and leftIcon in LenraRow should not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraFlex(
              fillParent: true,
              children: [
                LenraButton(
                  text: "test",
                  onPressed: () => {},
                  leftIcon: const Icon(Icons.ac_unit_outlined),
                  rightIcon: const Icon(Icons.ac_unit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('LenraButton should not have a border on Primary and Tertiary types', (WidgetTester tester) async {
    var noneBorderSide = const BorderSide(color: Color(0xff000000), width: 0.0, style: BorderStyle.none);

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        type: LenraComponentType.primary,
        size: LenraComponentSize.large,
        onPressed: () {},
      ),
    ));

    // The LenraButton component contains a TextButton which contains the style we need
    expect((tester.widget(find.byType(TextButton)) as TextButton).style!.side!.resolve({}), equals(noneBorderSide));

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        type: LenraComponentType.tertiary,
        size: LenraComponentSize.large,
        onPressed: () {},
      ),
    ));

    expect((tester.widget(find.byType(TextButton)) as TextButton).style!.side!.resolve({}), equals(noneBorderSide));
  });

  testWidgets('LenraButton text/leftIcon/rightIcon alone should not use LenraRow', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        onPressed: () {},
      ),
    ));

    expect(find.byType(LenraFlex), findsNothing);

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        leftIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));

    expect(find.byType(LenraFlex), findsNothing);

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        rightIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));

    expect(find.byType(LenraFlex), findsNothing);
  });

  testWidgets('LenraButton text/icons combinations should not crash', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        leftIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        rightIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        leftIcon: const Icon(Icons.ac_unit),
        rightIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));

    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        leftIcon: const Icon(Icons.ac_unit),
        rightIcon: const Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ));
  });
}
