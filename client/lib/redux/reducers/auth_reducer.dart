import 'package:fr_lenra_client/api/response_models/token_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authStateReducer = combineReducers([
  TypedReducer<AuthState, RegisterAction>(handleRegisterAction),
  TypedReducer<AuthState, VerifyCodeAction>(handleSendCodeAction),
  TypedReducer<AuthState, LoginAction>(handleLoginAction),
  TypedReducer<AuthState, RemoveAccessTokenAction>(handleRemoveTokenAction),
  TypedReducer<AuthState, AsyncAction<TokenResponse>>(handleTokenResponse),
]);

AuthState handleTokenResponse(AuthState state, AsyncAction<TokenResponse> action) {
  if (action.isDone) {
    return state.copyWith(tokenResponse: action.data);
  }
  return state;
}

AuthState handleRemoveTokenAction(AuthState state, RemoveAccessTokenAction action) {
  return state.copyWith(
    tokenResponse: null,
  );
}

AuthState handleLoginAction(AuthState state, LoginAction action) {
  return state.copyWith(
    loginStatus: state.loginStatus.reducer(action),
  );
}

AuthState handleRegisterAction(AuthState state, RegisterAction action) {
  return state.copyWith(
    registerStatus: state.registerStatus.reducer(action),
  );
}

AuthState handleSendCodeAction(AuthState state, VerifyCodeAction action) {
  return state.copyWith(
    verifyCodeStatus: state.verifyCodeStatus.reducer(action),
  );
}
