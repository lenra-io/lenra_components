import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/recovery_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class RecoveryModel extends AsyncStatusModel<RecoveryAction> {
  RecoveryModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.sendLostPasswordCodeStatus;
  }

  RecoveryAction createAction([ApiRequest body]) {
    return RecoveryAction(body);
  }
}
