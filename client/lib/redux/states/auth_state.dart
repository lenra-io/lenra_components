import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

@immutable
class AuthState {
  final AuthResponse authResponse;
  final AsyncStatus registerStatus;
  final AsyncStatus activationCodeStatus;
  final AsyncStatus verifyCodeStatus;
  final AsyncStatus refreshStatus;
  final AsyncStatus loginStatus;
  final AsyncStatus logoutStatus;
  final AsyncStatus sendLostPasswordCodeStatus;
  final AsyncStatus lostPasswordModificationStatus;
  final AsyncStatus passwordModificationStatus;
  final String redirectToRoute;

  AuthState({
    AuthResponse authResponse,
    AsyncStatus registerStatus,
    AsyncStatus activationCodeStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus refreshStatus,
    AsyncStatus loginStatus,
    AsyncStatus logoutStatus,
    AsyncStatus sendLostPasswordCodeStatus,
    AsyncStatus lostPasswordModificationStatus,
    AsyncStatus passwordModificationStatus,
    this.redirectToRoute,
  })  : this.authResponse = authResponse ?? null,
        this.registerStatus = registerStatus ?? AsyncStatus(),
        this.activationCodeStatus = activationCodeStatus ?? AsyncStatus(),
        this.verifyCodeStatus = verifyCodeStatus ?? AsyncStatus(),
        this.loginStatus = loginStatus ?? AsyncStatus(),
        this.refreshStatus = refreshStatus ?? AsyncStatus(),
        this.logoutStatus = logoutStatus ?? AsyncStatus(),
        this.sendLostPasswordCodeStatus = sendLostPasswordCodeStatus ?? AsyncStatus(),
        this.lostPasswordModificationStatus = lostPasswordModificationStatus ?? AsyncStatus(),
        this.passwordModificationStatus = passwordModificationStatus ?? AsyncStatus();

  AuthState copyWith({
    AuthResponse tokenResponse,
    AsyncStatus registerStatus,
    AsyncStatus activationCodeStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus refreshStatus,
    AsyncStatus loginStatus,
    AsyncStatus logoutStatus,
    AsyncStatus sendLostPasswordCodeStatus,
    AsyncStatus lostPasswordModificationStatus,
    AsyncStatus passwordModificationStatus,
    String redirectToRoute,
  }) {
    return AuthState(
      authResponse: tokenResponse ?? this.authResponse,
      registerStatus: registerStatus ?? this.registerStatus,
      activationCodeStatus: activationCodeStatus ?? this.activationCodeStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      sendLostPasswordCodeStatus: sendLostPasswordCodeStatus ?? this.sendLostPasswordCodeStatus,
      lostPasswordModificationStatus: lostPasswordModificationStatus ?? this.lostPasswordModificationStatus,
      passwordModificationStatus: passwordModificationStatus ?? this.passwordModificationStatus,
      redirectToRoute: redirectToRoute ?? this.redirectToRoute,
    );
  }

  Map<String, dynamic> toJson() => {
        "authResponse": authResponse,
        "registerStatus": registerStatus.toJson(),
        "activationCodeStatus": activationCodeStatus.toJson(),
        "verifyCodeStatus": verifyCodeStatus.toJson(),
        "refreshStatus": refreshStatus.toJson(),
        "loginStatus": loginStatus.toJson(),
        "logoutStatus": logoutStatus.toJson(),
        "sendLostPasswordCodeStatus": sendLostPasswordCodeStatus.toJson(),
        "lostPasswordModificationStatus": lostPasswordModificationStatus.toJson(),
        "passwordModificationStatus": passwordModificationStatus.toJson(),
        "redirectToRoute": redirectToRoute,
      };

  static AuthState fromJson(dynamic json) {
    return AuthState(authResponse: json["authResponse"]);
  }
}
