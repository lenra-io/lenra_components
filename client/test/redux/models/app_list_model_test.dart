import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('AppListModel status', () {
    Store<AppState> store = createFakeStore();
    AppListModel model = AppListModel(store);

    expect(model.status, store.state.applicationState.appListState);
    expect(model.data, store.state.applicationState.appListState.data);
  });

  test('AppListModel action creation', () {
    testModelAction<AppListModel, FetchApplicationsAction>(
      (store) => AppListModel(store),
    );
  });
}
