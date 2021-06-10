import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

import '../page/lenra_page_test_help.dart';

void main() {
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
}
