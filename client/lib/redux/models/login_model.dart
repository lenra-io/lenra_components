import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class LoginModel extends AsyncStatusModel<LoginAction> {
  LoginModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.loginStatus;
  }

  LoginAction createAction([ApiRequest body]) {
    return LoginAction(body);
  }
}
