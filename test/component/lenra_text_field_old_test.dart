import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text_field_old.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  const String fourLines = 'First line\n'
      'Second line\n'
      'Third line\n'
      'Fourth line';

  test('LenraTextFieldOld test', () {
    LenraTextFieldOld component = LenraTextFieldOld(
      onChanged: (String test) {},
    );
    expect(component is LenraTextFieldOld, true);
  });

  testWidgets('Test LenraTextFieldOld Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFieldOld(
        size: LenraComponentSize.small,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(24.0));
  });
  testWidgets('Test LenraTextFieldOld Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFieldOld(
        size: LenraComponentSize.medium,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(32.0));
  });

  testWidgets('Test LenraTextFieldOld Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextFieldOld(
        size: LenraComponentSize.large,
        onChanged: (String test) {},
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(40.0));
  });

  testWidgets('Test LenraTextFieldOld error minLines greater than maxLines', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(createAppTestWidgets(LenraTextFieldOld(minLines: 3)));
    }, throwsAssertionError);
  });

  testWidgets('Test LenraTextFieldOld minLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextFieldOld(
        minLines: 2,
        maxLines: null,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(48.0));
  });

  testWidgets('Test LenraTextFieldOld minLines size with text doesnt expand', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextFieldOld(
        minLines: 1,
        maxLines: 1,
      ),
    ));

    await tester.enterText(find.byType(LenraTextFieldOld), fourLines);

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(32.0));
  });

  testWidgets('Test LenraTextFieldOld maxLines size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextFieldOld(
        maxLines: 4,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(80.0));
  });

  testWidgets('Test LenraTextFieldOld maxLines size with text expands', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTextFieldOld(
        minLines: 2,
        maxLines: 6,
      ),
    ));

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(48.0));

    await tester.enterText(find.byType(LenraTextFieldOld), fourLines);
    await tester.pump();

    expect(tester.getSize(find.byType(LenraTextFieldOld)).height, equals(80.0));
  });
}
