import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/refresh_token_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:fr_lenra_client/socket/lenra_socket.dart';
import 'package:redux/redux.dart';

Future socketMiddleware(
  Store<AppState> store,
  Action action,
  NextDispatcher next,
) async {
  next(action);

  if (action is LoginAction ||
      action is RegisterAction ||
      action is VerifyCodeAction) {
    if ((action as AsyncAction).isDone) {
      createLenraSocketInstance(store);
    }
  }

  if (action is RefreshTokenAction) {
    if (action.isDone && LenraSocket.instance == null) {
      createLenraSocketInstance(store);
    }
  }
}

void createLenraSocketInstance(Store<AppState> store) {
  LenraSocket.createInstance(
    store.state.authState.tokenResponse.accessToken,
  ).connect();
}
