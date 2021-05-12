import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

/// The action to get the Lenra applications
class FetchUserApplicationsAction extends AsyncAction<AppsResponse> {
  FetchUserApplicationsAction() : super(future: () => ApplicationApi.getUserApps());
}
