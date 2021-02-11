import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class VerifyCodeModel extends AsyncStatusModel<VerifyCodeAction> {
  VerifyCodeModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.verifyCodeStatus;
  }

  VerifyCodeAction createAction([ApiRequest body]) {
    return VerifyCodeAction(body);
  }
}
