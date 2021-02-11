import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';

void main() {
  test('async action tests', () {
    FetchApplicationsAction action = FetchApplicationsAction();
    expect(action is Action, true);
    expect(action.future is Function, true);
    expect(action.isDone, false);
    expect(action.isError, false);
    expect(action.isFetching, false);
    expect(action.status, RequestStatus.none);
    expect(action.isRetry, false);
    expect(action.data, null);
    expect(action.errors, null);

    action.status = RequestStatus.done;
    expect(action.isDone, true);
    expect(action.isError, false);
    expect(action.isFetching, false);

    action.status = RequestStatus.error;
    expect(action.isDone, false);
    expect(action.isError, true);
    expect(action.isFetching, false);

    action.status = RequestStatus.fetching;
    expect(action.isDone, false);
    expect(action.isError, false);
    expect(action.isFetching, true);
  });
}
