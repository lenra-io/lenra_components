import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/models/verify_code_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('VerifyCodeModel status', () {
    Store<AppState> store = createFakeStore();
    VerifyCodeModel model = VerifyCodeModel(store);

    expect(model.status, store.state.authState.verifyCodeStatus);
  });

  test('VerifyCodeModel action creation', () {
    testModelAction<VerifyCodeModel, VerifyCodeAction>(
      (store) => VerifyCodeModel(store),
      body: VerifyCodeRequest("code"),
    );
  });
}
