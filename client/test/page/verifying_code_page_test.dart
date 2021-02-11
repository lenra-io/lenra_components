import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/verify_code_page/verify_code_form_container.dart';
import 'package:fr_lenra_client/page/verifiying_code_page.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../redux/fake_store.dart';

void main() {
  testWidgets('expect VerifyingCodePage to build correctly', (WidgetTester tester) async {
    Store<AppState> store = createFakeStore();
    await tester.pumpWidget(MaterialApp(
      home: StoreProvider<AppState>(store: store, child: VerifyingCodePage()),
    ));
    final finder = find.byType(VerifyCodeFormContainer);
    expect(finder, findsOneWidget);
  });
}
