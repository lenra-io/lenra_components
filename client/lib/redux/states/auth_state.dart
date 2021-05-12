import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

@immutable
class AuthState {
  final AuthResponse authResponse;
  final AsyncStatus registerStatus;
  final AsyncStatus verifyCodeStatus;
  final AsyncStatus loginStatus;
  final AsyncStatus logoutStatus;
  final AsyncStatus sendLostPasswordCodeStatus;
  final AsyncStatus lostPasswordModificationStatus;
  final AsyncStatus passwordModificationStatus;

  AuthState({
    AuthResponse authResponse,
    AsyncStatus registerStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus loginStatus,
    AsyncStatus logoutStatus,
    AsyncStatus sendLostPasswordCodeStatus,
    AsyncStatus lostPasswordModificationStatus,
    AsyncStatus passwordModificationStatus,
  })  : this.authResponse = authResponse ?? null,
        this.registerStatus = registerStatus ?? AsyncStatus(),
        this.verifyCodeStatus = verifyCodeStatus ?? AsyncStatus(),
        this.loginStatus = loginStatus ?? AsyncStatus(),
        this.logoutStatus = logoutStatus ?? AsyncStatus(),
        this.sendLostPasswordCodeStatus = sendLostPasswordCodeStatus ?? AsyncStatus(),
        this.lostPasswordModificationStatus = lostPasswordModificationStatus ?? AsyncStatus(),
        this.passwordModificationStatus = passwordModificationStatus ?? AsyncStatus();

  AuthState copyWith({
    AuthResponse tokenResponse,
    AsyncStatus registerStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus loginStatus,
    AsyncStatus logoutStatus,
    AsyncStatus sendLostPasswordCodeStatus,
    AsyncStatus lostPasswordModificationStatus,
    AsyncStatus passwordModificationStatus,
  }) {
    return AuthState(
      authResponse: tokenResponse ?? this.authResponse,
      registerStatus: registerStatus ?? this.registerStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      sendLostPasswordCodeStatus: sendLostPasswordCodeStatus ?? this.sendLostPasswordCodeStatus,
      lostPasswordModificationStatus: lostPasswordModificationStatus ?? this.lostPasswordModificationStatus,
      passwordModificationStatus: passwordModificationStatus ?? this.passwordModificationStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "authResponse": authResponse,
        "registerStatus": registerStatus.toJson(),
        "verifyCodeStatus": verifyCodeStatus.toJson(),
        "loginStatus": loginStatus.toJson(),
        "logoutStatus": logoutStatus.toJson(),
        "sendLostPasswordCodeStatus": sendLostPasswordCodeStatus.toJson(),
        "lostPasswordModificationStatus": lostPasswordModificationStatus.toJson(),
        "passwordModificationStatus": passwordModificationStatus.toJson(),
      };

  static AuthState fromJson(dynamic json) {
    return AuthState(authResponse: json["authResponse"]);
  }
}
