import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to connect on Lenra
class LogoutAction extends AsyncAction<EmptyResponse> {
  LogoutAction() : super(future: () => UserApi.logout());
}
