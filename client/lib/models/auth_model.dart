import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/request_models/ask_code_lost_password_request.dart';
import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/request_models/send_code_lost_password_request.dart';
import 'package:fr_lenra_client/api/request_models/validate_dev_request.dart';
import 'package:fr_lenra_client/api/request_models/validate_user_request.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/api/user_api.dart';
import 'package:fr_lenra_client/models/status.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';

class AuthModel extends ChangeNotifier {
  String? accessToken;
  User? user;
  final Status<AuthResponse> registerStatus = Status();
  final Status<AuthResponse> loginStatus = Status();
  final Status<AuthResponse> refreshStatus = Status();
  final Status<AuthResponse> validateUserStatus = Status();
  final Status<AuthResponse> validateDevStatus = Status();

  final Status<EmptyResponse> logoutStatus = Status();

  final Status<EmptyResponse> askCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> sendCodeLostPasswordStatus = Status();
  final Status<EmptyResponse> changePasswordStatus = Status();

  String? _redirectToRoute;
  String? get redirectToRoute => _redirectToRoute;
  set redirectToRoute(String? newValue) {
    this._redirectToRoute = newValue;
    // notifyListeners();
  }

  bool isAuthenticated() {
    return this.accessToken != null && this.user != null;
  }

  bool isOneOfRole(List<UserRole> roles) {
    if (this.user == null) return false;
    return roles.contains(this.user?.role);
  }

  AuthResponse _handleAuthResponse(AuthResponse res) {
    this.accessToken = res.accessToken;
    // Set the token for the global API instance
    LenraApi.instance.token = this.accessToken;
    this.user = res.user;
    notifyListeners();
    return res;
  }

  Future<AuthResponse> register(String email, String password) async {
    var res = await registerStatus.handle(() => UserApi.register(RegisterRequest(email, password)), notifyListeners);
    this._handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> login(String email, String password) async {
    var res = await loginStatus.handle(() => UserApi.login(LoginRequest(email, password)), notifyListeners);
    this._handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> refresh() async {
    var res = await refreshStatus.handle(UserApi.refresh, notifyListeners);
    this._handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> validateUser(String code) async {
    var res = await validateUserStatus.handle(() => UserApi.validateUser(ValidateUserRequest(code)), notifyListeners);
    this._handleAuthResponse(res);
    return res;
  }

  Future<AuthResponse> validateDev(String code) async {
    var res = await validateDevStatus.handle(() => UserApi.validateDev(ValidateDevRequest(code)), notifyListeners);
    this._handleAuthResponse(res);
    return res;
  }

  Future<EmptyResponse> logout() async {
    var res = await logoutStatus.handle(UserApi.logout, notifyListeners);
    this.accessToken = null;
    this.user = null;
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> askCodeLostPassword(String email) async {
    var res = await askCodeLostPasswordStatus.handle(
        () => UserApi.askCodeLostPassword(AskCodeLostPasswordRequest(email)), notifyListeners);
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> sendCodeLostPassword(String code, String email, String password, String confirmation) async {
    var res = await sendCodeLostPasswordStatus.handle(
        () => UserApi.sendCodeLostPassword(SendCodeLostPasswordRequest(code, email, password, confirmation)),
        notifyListeners);
    notifyListeners();
    return res;
  }

  Future<EmptyResponse> changePassword(String old, String password, String confirmation) async {
    var res = await changePasswordStatus.handle(
        () => UserApi.changePassword(ChangePasswordRequest(old, password, confirmation)), notifyListeners);
    notifyListeners();
    return res;
  }

  String getRedirectionRouteAfterAuthentication() {
    return this._redirectToRoute ?? LenraNavigator.HOME_ROUTE;
  }
}
