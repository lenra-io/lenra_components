import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/page/store_page.dart';
import 'package:fr_lenra_client/components/store_page/app_list_container.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../redux/fake_store.dart';

void main() {
  testWidgets('expect StorePage to build correctly', (WidgetTester tester) async {
    Store<AppState> store = createFakeStore();
    await tester.pumpWidget(MaterialApp(
      home: StoreProvider<AppState>(store: store, child: StorePage()),
    ));
    final finder = find.byType(AppListContainer);
    expect(finder, findsOneWidget);
  });
}
