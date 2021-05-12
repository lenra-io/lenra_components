import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/activation_code_page/activation_code_form_container.dart';
import 'package:fr_lenra_client/components/page/backoffice/activation_code_page.dart';

import 'lenra_page_test_help.dart';

void main() {
  testWidgets('expect ActivationCodePage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createBaseTestWidgets(ActivationCodePage()));
    final finder = find.byType(ActivationCodeFormContainer);
    expect(finder, findsOneWidget);
  });
}
