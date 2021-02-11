import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/redux/states/async_state.dart';

@immutable
class ApplicationState {
  final AsyncState<AppsResponse> appListState;

  ApplicationState({
    AsyncState appListState,
  }) : this.appListState = appListState ?? AsyncState();

  ApplicationState copyWith({
    AsyncState<AppsResponse> appListState,
  }) {
    return ApplicationState(
      appListState: appListState ?? this.appListState,
    );
  }

  Map<String, dynamic> toJson() => {
        "appListState": appListState.toJson(),
      };
  static ApplicationState fromJson(dynamic json) {
    return ApplicationState();
  }
}
