import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/activation_code_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class ActivationCodeModel extends AsyncStatusModel<ActivationCodeAction> {
  ActivationCodeModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.activationCodeStatus;
  }

  ActivationCodeAction createAction([ApiRequest body]) {
    return ActivationCodeAction(body);
  }
}
