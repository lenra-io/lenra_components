import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

// @immutable
class ApplicationState {
  AsyncState<AppsResponse> _appListState;
  AsyncStatus _fetchUserAppsStatus;
  AsyncStatus _createAppStatus;
  final List<AppResponse> userApplications;

  ApplicationState({
    AsyncState<AppsResponse> appListState,
    AsyncStatus fetchUserAppsStatus,
    AsyncStatus createAppStatus,
    this.userApplications = const [],
  }) {
    this._appListState = appListState ?? AsyncState();
    this._fetchUserAppsStatus = fetchUserAppsStatus ?? AsyncStatus();
    this._createAppStatus = createAppStatus ?? AsyncStatus();
  }

  AsyncState<AppsResponse> get appListState => _appListState;
  AsyncStatus get fetchUserAppsStatus => _fetchUserAppsStatus;
  AsyncStatus get createAppStatus => _createAppStatus;

  ApplicationState copyWith({
    AsyncState<AppsResponse> appListState,
    AsyncStatus fetchUserAppsStatus,
    AsyncStatus createAppStatus,
    List<AppResponse> userApplications,
  }) {
    return ApplicationState(
      appListState: appListState ?? this._appListState,
      fetchUserAppsStatus: fetchUserAppsStatus ?? this._fetchUserAppsStatus,
      createAppStatus: createAppStatus ?? this._createAppStatus,
      userApplications: userApplications ?? this.userApplications,
    );
  }

  Map<String, dynamic> toJson() => {
        "appListState": _appListState.toJson(),
        "fetchUserAppsStatus": _fetchUserAppsStatus.toJson(),
        "createAppStatus": _createAppStatus.toJson(),
        "userApplications": userApplications.map((e) => e.toJson()).toList(),
      };

  static ApplicationState fromJson(dynamic json) {
    return ApplicationState();
  }
}
