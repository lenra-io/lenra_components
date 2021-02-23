import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/reducers/application_reducer.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';

import '../actions/fake_action.dart';
import 'reducer_test_helpers.dart';

void main() {
  test('application reducer action not handled', () {
    ApplicationState applicationState = ApplicationState();
    ApplicationState newApplicationState = applicationsReducer(applicationState, FakeAction());
    expect(identical(applicationState, newApplicationState), true);
  });

  testState<ApplicationState, AppsResponse>(
    ApplicationState(),
    FetchApplicationsAction(),
    applicationsReducer,
    (state) => state.appListState,
    AppsResponse.fromJson({
      "apps": [
        {"name": "appName", "icon": 60184, "color": "FFFFFF"}
      ]
    }),
  );
}
