import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  const String fourLines = 'First line\n'
      'Second line\n'
      'Third line\n'
      'Fourth line';

  test('LenraTextField test', () {
    LenraTextField component = LenraTextField(
      onChanged: (String test) {},
    );
    expect(component is LenraTextField, true);
  });

  testWidgets('Test LenraTextField Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.small,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(28.0));
  });
  testWidgets('Test LenraTextField Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.medium,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(36.0));
  });

  testWidgets('Test LenraTextField Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.large,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(44.0));
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

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(48.0));
  });

  testWidgets('Test LenraTextField minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextField), fourLines);

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(32.0));
  });

  testWidgets('Test LenraTextField maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(80.0));
  });

  testWidgets('Test LenraTextField maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextField(
        minLines: 2,
        maxLines: 6,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(48.0));

    await tester.enterText(find.byType(LenraTextField), fourLines);
    await tester.pump();

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(80.0));
  });
}
