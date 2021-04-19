import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/redux/actions/recovery_action.dart';
import 'package:fr_lenra_client/redux/models/recovery_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';
import 'model_test_helper.dart';

void main() {
  test('RecoveryModel status', () {
    Store<AppState> store = createFakeStore();
    RecoveryModel model = RecoveryModel(store);

    expect(model.status, store.state.authState.sendLostPasswordCodeStatus);
  });

  test('RecoveryModel action creation', () {
    testModelAction<RecoveryModel, RecoveryAction>(
      (store) => RecoveryModel(store),
      body: RecoveryRequest("email"),
    );
  });
}
