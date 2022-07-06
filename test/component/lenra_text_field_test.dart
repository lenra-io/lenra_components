import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_components.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  const String fourLines = 'First line\n'
      'Second line\n'
      'Third line\n'
      'Fourth line';

  testWidgets('Test LenraTextField Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.small,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(20 + 8));
  });
  testWidgets('Test LenraTextField Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.medium,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(20 + 16));
  });

  testWidgets('Test LenraTextField Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.large,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(20 + 24));
  });

  testWidgets('Test LenraTextField without border', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTheme(
        themeData: LenraThemeData(
          lenraBorderThemeData: LenraBorderThemeData(
            primaryBorder: const BorderSide(width: 0),
          ),
        ),
        child: LenraTextField(
          onChanged: (String test) {},
        ),
      ),
    ));

    expect(tester.getSize(find.byType(EditableText)).height, equals(20.0));
    expect(tester.getSize(find.byType(TextField)).height, equals(20 + 16));
    expect(tester.getSize(find.byType(LenraTextField)).height, equals(20 + 16));
  });

  testWidgets('Test LenraTextField error minLines greater than maxLines', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(createAppTestWidgets(LenraTextField(minLines: 3)));
    }, throwsAssertionError);
  });

  testWidgets('Test LenraTextField minLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        minLines: 2,
        maxLines: null,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(2 * 20 + 16));
  });

  testWidgets('Test LenraTextField minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextField), fourLines);

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(20 + 16));
  });

  testWidgets('Test LenraTextField maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(4 * 20 + 16));
  });

  testWidgets('Test LenraTextField maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        minLines: 2,
        maxLines: 6,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(2 * 20 + 16));

    await tester.enterText(find.byType(LenraTextField), fourLines);
    await tester.pump();

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(4 * 20 + 16));
  });
}
