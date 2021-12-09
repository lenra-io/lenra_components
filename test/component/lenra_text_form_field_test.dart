import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/component/lenra_text_form_field.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  const String fourLines = 'First line\n'
      'Second line\n'
      'Third line\n'
      'Fourth line';

  test('LenraTextFormField test', () {
    LenraTextFormField component = LenraTextFormField(
      onChanged: (String test) {},
    );
    expect(component is LenraTextFormField, true);
  });

  testWidgets('Test LenraTextFormField create TextField', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        onChanged: (String test) {},
      ),
    ));

    expect(find.byType(LenraTextField), findsOneWidget);
  });

  testWidgets('Test LenraTextFormField error minLines greater than maxLines', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(createAppTestWidgets(LenraTextFormField(minLines: 3)));
    }, throwsAssertionError);
  });

  testWidgets('Test LenraTextFormField minLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        minLines: 2,
        maxLines: null,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(32.0));
  });

  testWidgets('Test LenraTextFormField minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextFormField), fourLines);

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(16.0));
  });

  testWidgets('Test LenraTextFormField maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(16.0));
  });

  testWidgets('Test LenraTextFormField maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        minLines: 2,
        maxLines: 6,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(32.0));
    await tester.enterText(find.byType(LenraTextFormField), fourLines);
    await tester.pump();

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(64.0));
  });

  testWidgets('Test validator', (WidgetTester tester) async {
    int _validateCalled = 0;

    await tester.pumpWidget(createComponentTestWidgets(
      Material(
        child: LenraTextFormField(
          enabled: true,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) {
            _validateCalled += 1;
            return null;
          },
        ),
      ),
    ));

    expect(_validateCalled, 1);
    expect(find.byType(LenraTextField), findsOneWidget);
    await tester.enterText(find.byType(LenraTextField), "foo");
    await tester.pump();
    expect(_validateCalled, 2);
  });
}
