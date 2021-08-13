import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

import '../page/lenra_page_test_help.dart';

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
        size: LenraComponentSize.Small,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(24.0));
  });
  testWidgets('Test LenraTextField Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.Medium,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(32.0));
  });

  testWidgets('Test LenraTextField Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        size: LenraComponentSize.Large,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(40.0));
  });

  testWidgets('Test LenraTextField error minLines greater than maxLines', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(createAppTestWidgets(LenraTextField(minLines: 3)));
    }, throwsAssertionError);
  });

  testWidgets('Test LenraTextField minLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        minLines: 2,
        maxLines: null,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(48.0));
  });

  testWidgets('Test LenraTextField minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextField), fourLines);

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(32.0));
  });

  testWidgets('Test LenraTextField maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextField)).height, equals(80.0));
  });

  testWidgets('Test LenraTextField maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
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
