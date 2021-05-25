import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/redux/actions/fetch_user_applications_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

class UserAppListModel extends AsyncStatusModel<FetchUserApplicationsAction> {
  const UserAppListModel(_store) : super(_store);

  FetchUserApplicationsAction createAction([ApiRequest body]) {
    return FetchUserApplicationsAction();
  }

  AsyncStatus get status {
    return store.state.applicationState.fetchUserAppsStatus;
  }

  List<AppResponse> get data {
    return store.state.applicationState.userApplications;
  }
}
