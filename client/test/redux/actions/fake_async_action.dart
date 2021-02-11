import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

class FakeApiResponse extends ApiResponse {
  String fake = "fakeData";
}

class FakeAsyncAction extends AsyncAction<FakeApiResponse> {
  FakeAsyncAction({bool failure = false})
      : super(future: () {
          if (!failure) {
            return Future.value(FakeApiResponse());
          } else {
            return Future.error(ApiErrors.fromJson([]));
          }
        });
}
