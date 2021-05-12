import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';
import 'package:fr_lenra_client/redux/states/backoffice_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final ApplicationState applicationState;
  final BackofficeState backofficeState;

  AppState({
    AuthState authState,
    ApplicationState applicationState,
    BackofficeState backofficeState,
  })  : this.authState = authState ?? AuthState(),
        this.applicationState = applicationState ?? ApplicationState(),
        this.backofficeState = backofficeState ?? BackofficeState();

  AppState copyWith({AuthState authState, ApplicationState applicationState}) {
    return AppState(
      authState: authState ?? this.authState,
      applicationState: applicationState ?? this.applicationState,
      backofficeState: backofficeState ?? this.backofficeState,
    );
  }

  Map<String, dynamic> toJson() => {
        "authState": authState.toJson(),
        "applicationState": applicationState.toJson(),
        "backofficeState": backofficeState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState();
    }
    return AppState(
      authState: AuthState.fromJson(json["authState"]),
      applicationState: ApplicationState.fromJson(json["applicationState"]),
      backofficeState: BackofficeState.fromJson(json["backofficeState"]),
    );
  }
}
