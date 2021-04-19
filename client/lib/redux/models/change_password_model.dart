import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/change_password_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class ChangePasswordModel extends AsyncStatusModel<ChangePasswordAction> {
  ChangePasswordModel(store) : super(store);

  AsyncStatus get status {
    return store.state.authState.passwordModificationStatus;
  }

  ChangePasswordAction createAction([ApiRequest body]) {
    return ChangePasswordAction(body);
  }
}
