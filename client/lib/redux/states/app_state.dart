import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final ApplicationState applicationState;

  AppState({
    AuthState authState,
    ApplicationState applicationState,
  })  : this.authState = authState ?? AuthState(),
        this.applicationState = applicationState ?? ApplicationState();

  AppState copyWith({AuthState authState, ApplicationState applicationState}) {
    return AppState(
      authState: authState ?? this.authState,
      applicationState: applicationState ?? this.applicationState,
    );
  }

  Map<String, dynamic> toJson() => {
        "authState": authState.toJson(),
        "applicationState": applicationState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState();
    }
    return AppState(
      authState: AuthState.fromJson(json["authState"]),
      applicationState: ApplicationState.fromJson(json["applicationState"]),
    );
  }
}
