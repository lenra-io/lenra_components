import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/models/login_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('LoginModel status', () {
    Store<AppState> store = createFakeStore();
    LoginModel model = LoginModel(store);

    expect(model.status, store.state.authState.loginStatus);
  });

  test('LoginModel action creation', () {
    testModelAction<LoginModel, LoginAction>(
      (store) => LoginModel(store),
      body: LoginRequest("", ""),
    );
  });
}
