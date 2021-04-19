import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/redux/actions/change_password_action.dart';
import 'package:fr_lenra_client/redux/models/change_password_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('ChangePasswordModel status', () {
    Store<AppState> store = createFakeStore();
    ChangePasswordModel model = ChangePasswordModel(store);

    expect(model.status, store.state.authState.passwordModificationStatus);
  });

  test('ChangePasswordModel action creation', () {
    testModelAction<ChangePasswordModel, ChangePasswordAction>(
      (store) => ChangePasswordModel(store),
      body: ChangePasswordRequest("", "", ""),
    );
  });
}
