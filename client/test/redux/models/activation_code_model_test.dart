import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/redux/actions/activation_code_action.dart';
import 'package:fr_lenra_client/redux/models/activation_code_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('ActivationCodeModel status', () {
    Store<AppState> store = createFakeStore();
    ActivationCodeModel model = ActivationCodeModel(store);

    expect(model.status, store.state.authState.verifyCodeStatus);
  });

  test('ActivationCodeModel action creation', () {
    testModelAction<ActivationCodeModel, ActivationCodeAction>(
      (store) => ActivationCodeModel(store),
      body: ActivationCodeRequest("code"),
    );
  });
}
