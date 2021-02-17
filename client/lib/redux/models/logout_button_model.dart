import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/logout_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class LogoutButtonModel extends AsyncStatusModel<LogoutAction> {
  LogoutButtonModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.logoutStatus;
  }

  LogoutAction createAction([ApiRequest body]) {
    return LogoutAction();
  }
}
