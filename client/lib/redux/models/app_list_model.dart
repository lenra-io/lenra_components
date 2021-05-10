import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
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

  AppResponse getAppInfoByName(String name) {
    //TODO : Needed to put null checks, but it should be fixed elsewhere
    return this.data?.apps?.firstWhere((AppResponse appInfo) => appInfo.name == name);
  }

  AppResponse getAppInfoByServiceName(String serviceName) {
    return this.data.apps.firstWhere((AppResponse appInfo) => appInfo.serviceName == serviceName);
  }
}
