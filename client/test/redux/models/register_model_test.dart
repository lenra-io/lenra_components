import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/models/register_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('RegisterModel status', () {
    Store<AppState> store = createFakeStore();
    RegisterModel model = RegisterModel(store);

    expect(model.status, store.state.authState.registerStatus);
  });

  test('RegisterModel action creation', () {
    testModelAction<RegisterModel, RegisterAction>(
      (store) => RegisterModel(store),
      body: RegisterRequest("", "", "", ""),
    );
  });
}
