import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/component/lenra_text_form_field.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  const String fourLines = 'First line\n'
      'Second line\n'
      'Third line\n'
      'Fourth line';

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

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(2 * 20 + 16));
  });

  testWidgets('Test LenraTextFormField minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextFormField), fourLines);

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(20 + 16));
  });

  testWidgets('Test LenraTextFormField maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(4 * 20 + 16));
  });

  testWidgets('Test LenraTextFormField maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFormField(
        minLines: 2,
        maxLines: 6,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(2 * 20 + 16));

    await tester.enterText(find.byType(LenraTextFormField), fourLines);
    await tester.pump();

    expect(tester.getSize(find.byType(LenraTextFormField)).height, equals(4 * 20 + 16));
  });
}
