import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/response_models/token_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to connect on Lenra
class LoginAction extends AsyncAction<TokenResponse> {
  LoginAction(
    LoginRequest body,
  ) : super(future: () => UserApi.login(body));
}
