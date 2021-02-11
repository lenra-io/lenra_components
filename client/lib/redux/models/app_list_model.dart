import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/models/async_state_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class AppListModel extends AsyncStateModel<AppsResponse, FetchApplicationsAction> {
  const AppListModel(_store) : super(_store);

  FetchApplicationsAction createAction([ApiRequest body]) {
    return FetchApplicationsAction();
  }

  AsyncStatus get status {
    return store.state.applicationState.appListState;
  }

  LenraApplicationInfo getAppInfoByName(String name) {
    return this
        .convertAppListToAppsInfo()
        .firstWhere((LenraApplicationInfo appInfo) => appInfo.name == name);
  }

  List<LenraApplicationInfo> convertAppListToAppsInfo() {
    final icon = [
      Icons.access_alarm,
      Icons.ac_unit,
      Icons.account_balance,
      Icons.account_box,
      Icons.announcement,
      Icons.backup,
      Icons.eco,
      Icons.tablet_android,
      Icons.save
    ];

    int i = 0;
    return this.data.apps.map((AppResponse app) {
      int index = (i * 2 + 1);
      i++;
      return LenraApplicationInfo(
          name: app.name,
          icon: icon[index % icon.length],
          color: Colors.primaries[index % Colors.primaries.length]);
    }).toList();
  }
}
