import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/change_lost_password_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class ChangeLostPasswordModel extends AsyncStatusModel<ChangeLostPasswordAction> {
  ChangeLostPasswordModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.lostPasswordModificationStatus;
  }

  ChangeLostPasswordAction createAction([ApiRequest body]) {
    return ChangeLostPasswordAction(body);
  }
}
