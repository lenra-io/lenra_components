import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class RegisterModel extends AsyncStatusModel<RegisterAction> {
  RegisterModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.registerStatus;
  }

  RegisterAction createAction([ApiRequest body]) {
    return RegisterAction(body);
  }

  void register(RegisterRequest body) {
    super.fetchData(body: body);
  }
}
