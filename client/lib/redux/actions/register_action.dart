import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to register on Lenra
class RegisterAction extends AsyncAction<AuthResponse> {
  RegisterAction(RegisterRequest body)
      : super(
          future: () => UserApi.register(body),
        );
}
