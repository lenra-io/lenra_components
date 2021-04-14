import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/page/register_page.dart';
import 'package:fr_lenra_client/components/register_page/register_form_container.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../redux/fake_store.dart';

void main() {
  testWidgets('expect RegisterPage to build correctly', (WidgetTester tester) async {
    Store<AppState> store = createFakeStore();
    await tester.pumpWidget(MaterialApp(
      home: StoreProvider<AppState>(store: store, child: RegisterPage()),
    ));
    final finder = find.byType(RegisterFormContainer);
    expect(finder, findsOneWidget);
  });
}
