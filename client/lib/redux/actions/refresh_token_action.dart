import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to get a refresh token
class RefreshTokenAction extends AsyncAction<AuthResponse> {
  AsyncAction actionToRetry;
  RefreshTokenAction(this.actionToRetry) : super(future: () => UserApi.refresh());
}
