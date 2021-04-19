import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/redux/actions/change_lost_password_action.dart';
import 'package:fr_lenra_client/redux/models/change_lost_password_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('ChangeLostPasswordModel status', () {
    Store<AppState> store = createFakeStore();
    ChangeLostPasswordModel model = ChangeLostPasswordModel(store);

    expect(model.status, store.state.authState.lostPasswordModificationStatus);
  });

  test('ChangeLostPasswordModel action creation', () {
    testModelAction<ChangeLostPasswordModel, ChangeLostPasswordAction>(
      (store) => ChangeLostPasswordModel(store),
      body: ChangeLostPasswordRequest("", "", "", ""),
    );
  });
}
