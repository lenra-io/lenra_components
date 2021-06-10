import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';

import '../page/lenra_page_test_help.dart';

void main() {
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

    expect(find.byType(LenraTextField) != null, true);
  });
}
