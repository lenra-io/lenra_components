import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to verify the code sent by email when registering
class VerifyCodeAction extends AsyncAction<AuthResponse> {
  VerifyCodeAction(
    VerifyCodeRequest body,
  ) : super(future: () => UserApi.verifyCode(body));
}
