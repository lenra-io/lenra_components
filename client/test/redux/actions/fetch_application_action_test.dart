import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';

void main() {
  test('FetchApplicationsAction tests', () {
    FetchApplicationsAction action = FetchApplicationsAction();
    expect(action is AsyncAction, true);
  });
}
