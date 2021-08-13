import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/page/backoffice/activation_code_page.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:provider/provider.dart';

import '../../../test/utils/lenra_page_test_help.dart';

void main() {
  testWidgets('ActivationCodePage check SimplePage', (WidgetTester tester) async {
    await tester.pumpWidget(createAppTestWidgets(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: ActivationCodePage(),
    )));

    final widgetFinder = find.byType(SimplePage);

    expect(widgetFinder, findsOneWidget);
  });

  testWidgets('ActivationCodePage check texts', (WidgetTester tester) async {
    await tester.pumpWidget(createAppTestWidgets(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: ActivationCodePage(),
    )));

    final textFinder = find.byType(Text);

    expect(textFinder, findsNWidgets(5));
  });
}
