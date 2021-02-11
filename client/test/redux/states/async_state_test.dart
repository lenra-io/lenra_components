import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/states/async_state.dart';

import '../actions/fake_async_action.dart';

void main() {
  test('async state create', () {
    var asyncState = AsyncState();
    expect(asyncState.isNone, true);
    expect(asyncState.isDone, false);
    expect(asyncState.isNoneOrError, true);
    expect(asyncState.hasError, false);
    expect(asyncState.isFetching, false);
  });

  test("async state reducer fetching", () {
    var asyncState = AsyncState();
    var asyncAction = FakeAsyncAction();

    asyncAction.status = RequestStatus.fetching;
    asyncState = asyncState.reducer(asyncAction);
    expect(asyncState.status, RequestStatus.fetching);
    expect(asyncState.data, null);
    expect(asyncState.errors, null);
    expect(asyncState.hasError, false);
    expect(asyncState.isNoneOrError, false);
    expect(asyncState.isDone, false);
    expect(asyncState.isFetching, true);
  });

  test("async state reducer done", () {
    var asyncState = AsyncState();
    var asyncAction = FakeAsyncAction();
    var apiResponse = FakeApiResponse();

    asyncAction.status = RequestStatus.done;
    asyncAction.data = apiResponse;
    asyncState = asyncState.reducer(asyncAction);
    expect(asyncState.status, RequestStatus.done);
    expect(asyncState.data, apiResponse);
    expect(asyncState.errors, null);
    expect(asyncState.hasError, false);
    expect(asyncState.isNoneOrError, false);
    expect(asyncState.isDone, true);
    expect(asyncState.isFetching, false);
  });

  test("async state reducer error", () {
    var asyncState = AsyncState();
    var asyncAction = FakeAsyncAction();

    asyncAction.status = RequestStatus.error;
    asyncAction.errors = ApiErrors.fromJson([]);
    asyncState = asyncState.reducer(asyncAction);
    expect(asyncState.status, RequestStatus.error);
    expect(asyncState.data, null);
    expect(asyncState.errors, []);
    expect(asyncState.hasError, true);
    expect(asyncState.isNoneOrError, true);
    expect(asyncState.isDone, false);
    expect(asyncState.isFetching, false);
  });
}
