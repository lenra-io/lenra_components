import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/redux/states/async_state.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

@immutable
class ApplicationState {
  final AsyncState<AppsResponse> appListState;
  final AsyncStatus fetchUserAppsStatus;
  final AsyncStatus createAppStatus;
  final List<AppResponse> userApplications;

  const ApplicationState({
    this.appListState = const AsyncState(),
    this.fetchUserAppsStatus = const AsyncStatus(),
    this.createAppStatus = const AsyncStatus(),
    this.userApplications = const [],
  });

  ApplicationState copyWith({
    AsyncState<AppsResponse> appListState,
    AsyncStatus fetchUserAppsStatus,
    AsyncStatus createAppStatus,
    List<AppResponse> userApplications,
  }) {
    return ApplicationState(
      appListState: appListState ?? this.appListState,
      fetchUserAppsStatus: fetchUserAppsStatus ?? this.fetchUserAppsStatus,
      createAppStatus: createAppStatus ?? this.createAppStatus,
      userApplications: userApplications ?? this.userApplications,
    );
  }

  Map<String, dynamic> toJson() => {
        "appListState": appListState.toJson(),
        "fetchUserAppsStatus": fetchUserAppsStatus.toJson(),
        "createAppStatus": createAppStatus.toJson(),
        "userApplications": userApplications.map((e) => e.toJson()).toList(),
      };

  static ApplicationState fromJson(dynamic json) {
    return ApplicationState();
  }
}
