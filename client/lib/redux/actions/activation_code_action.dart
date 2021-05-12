import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to verify the code sent by email when registering
class ActivationCodeAction extends AsyncAction<AuthResponse> {
  ActivationCodeAction(
    ActivationCodeRequest body,
  ) : super(future: () => ApplicationApi.activationCode(body));
}
