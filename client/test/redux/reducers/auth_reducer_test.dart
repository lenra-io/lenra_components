import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/api/response_models/token_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/reducers/auth_reducer.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';

import '../actions/fake_action.dart';
import 'reducer_test_helpers.dart';

void main() {
  test('auth reducer action not handled', () {
    AuthState authState = AuthState();
    AuthState newAuthState = authStateReducer(authState, FakeAction());
    expect(identical(authState, newAuthState), true);
  });

  testStatus<AuthState>(
    AuthState(),
    LoginAction(LoginRequest("email", "password")),
    authStateReducer,
    (state) => state.loginStatus,
  );

  test('auth reducer login token saved', () {
    LoginAction action = LoginAction(LoginRequest("email", "password"));
    action.status = RequestStatus.done;
    action.data = TokenResponse.fromJson({"access_token": "mytoken"});
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.tokenResponse.accessToken, "mytoken");
  });

  testStatus<AuthState>(
    AuthState(),
    RegisterAction(RegisterRequest("email", "firstName", "lastName", "password")),
    authStateReducer,
    (state) => state.registerStatus,
  );

  test('auth reducer register token saved', () {
    RegisterAction action =
        RegisterAction(RegisterRequest("email", "firstName", "lastName", "password"));
    action.status = RequestStatus.done;
    action.data = TokenResponse.fromJson({"access_token": "mytoken"});
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.tokenResponse.accessToken, "mytoken");
  });

  testStatus<AuthState>(
    AuthState(),
    VerifyCodeAction(VerifyCodeRequest("code")),
    authStateReducer,
    (state) => state.verifyCodeStatus,
  );

  test('auth reducer verify code token saved', () {
    VerifyCodeAction action = VerifyCodeAction(VerifyCodeRequest("code"));
    action.status = RequestStatus.done;
    action.data = TokenResponse.fromJson({"access_token": "mytoken"});
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.tokenResponse.accessToken, "mytoken");
  });
}
