import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to connect on Lenra
class ChangePasswordAction extends AsyncAction<EmptyResponse> {
  ChangePasswordAction(
    ChangePasswordRequest body,
  ) : super(future: () => UserApi.changePassword(body));
}
