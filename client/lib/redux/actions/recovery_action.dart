import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to connect on Lenra
class RecoveryAction extends AsyncAction<EmptyResponse> {
  String email;

  RecoveryAction(
    RecoveryRequest body,
  )   : email = body.email,
        super(future: () => UserApi.emailVerificationLostPassword(body));
}
