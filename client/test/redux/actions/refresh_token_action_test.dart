import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/actions/refresh_token_action.dart';

void main() {
  test('RefreshTokenAction tests', () {
    var toRetry = FetchApplicationsAction();
    RefreshTokenAction action = RefreshTokenAction(toRetry);
    expect(action is AsyncAction, true);
    expect(action.actionToRetry, toRetry);
  });
}
