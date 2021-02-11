import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/token_response.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

@immutable
class AuthState {
  final TokenResponse tokenResponse;
  final AsyncStatus registerStatus;
  final AsyncStatus verifyCodeStatus;
  final AsyncStatus loginStatus;

  AuthState({
    TokenResponse tokenResponse,
    AsyncStatus registerStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus loginStatus,
  })  : this.tokenResponse = tokenResponse ?? null,
        this.registerStatus = registerStatus ?? AsyncStatus(),
        this.verifyCodeStatus = verifyCodeStatus ?? AsyncStatus(),
        this.loginStatus = loginStatus ?? AsyncStatus();

  AuthState copyWith({
    TokenResponse tokenResponse,
    AsyncStatus registerStatus,
    AsyncStatus verifyCodeStatus,
    AsyncStatus loginStatus,
  }) {
    return AuthState(
      tokenResponse: tokenResponse ?? this.tokenResponse,
      registerStatus: registerStatus ?? this.registerStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "tokenResponse": tokenResponse,
        "registerStatus": registerStatus.toJson(),
        "verifyCodeStatus": verifyCodeStatus.toJson(),
        "loginStatus": loginStatus.toJson(),
      };

  static AuthState fromJson(dynamic json) {
    return AuthState(tokenResponse: json["tokenResponse"]);
  }
}
