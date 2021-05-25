import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/request_models/create_app_request.dart';
import 'package:fr_lenra_client/api/response_models/create_app_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

class CreateApplicationAction extends AsyncAction<CreateAppResponse> {
  CreateApplicationAction(CreateAppRequest body) : super(future: () => ApplicationApi.createApp(body));
}
