import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/logout_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/reducers/auth_reducer.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';

import '../actions/fake_action.dart';
import 'reducer_test_helpers.dart';

void main() {
  final String token = "mytoken";
  final int userId = 1;
  final String userEmail = "john@doe.com";
  final String userFirstName = "John";
  final String userLastName = "Doe";
  final String userRole = "user";
  Map<String, dynamic> json = {
    "access_token": token,
    "user": {
      "id": userId,
      "first_name": userFirstName,
      "last_name": userLastName,
      "role": userRole,
      "email": userEmail,
    }
  };
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

  test('auth reducer login token and user saved', () {
    LoginAction action = LoginAction(LoginRequest("email", "password"));
    action.status = RequestStatus.done;
    action.data = AuthResponse.fromJson(json);
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.authResponse.accessToken, "mytoken");
    expect(authState.authResponse.user.role, UserRole.user);
  });

  testStatus<AuthState>(
    AuthState(),
    RegisterAction(RegisterRequest("email", "firstName", "lastName", "password")),
    authStateReducer,
    (state) => state.registerStatus,
  );

  test('auth reducer register token and user saved', () {
    RegisterAction action = RegisterAction(RegisterRequest("email", "firstName", "lastName", "password"));
    action.status = RequestStatus.done;
    action.data = AuthResponse.fromJson(json);
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.authResponse.accessToken, "mytoken");
    expect(authState.authResponse.user.role, UserRole.user);
  });

  testStatus<AuthState>(
    AuthState(),
    VerifyCodeAction(VerifyCodeRequest("code")),
    authStateReducer,
    (state) => state.verifyCodeStatus,
  );

  test('auth reducer verify code token and user saved', () {
    VerifyCodeAction action = VerifyCodeAction(VerifyCodeRequest("code"));
    action.status = RequestStatus.done;
    action.data = AuthResponse.fromJson(json);
    AuthState authState = authStateReducer(AuthState(), action);
    expect(authState.authResponse.accessToken, "mytoken");
    expect(authState.authResponse.user.role, UserRole.user);
  });

  test('auth reducer verify remove token after logout', () {
    AuthState state = AuthState();
    LoginAction action = LoginAction(LoginRequest("email", "password"));
    action.status = RequestStatus.done;
    AuthResponse response = AuthResponse.fromJson(json);
    action.data = response;
    AuthState authState = authStateReducer(state, action);
    expect(authState.authResponse, response);
    LogoutAction action2 = LogoutAction();
    action2.status = RequestStatus.done;
    action2.data = EmptyResponse.fromJson({"success": true});
    authState = authStateReducer(state, action2);
    expect(authState.authResponse, null);
  });
}
