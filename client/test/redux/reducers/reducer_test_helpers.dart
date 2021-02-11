import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/states/async_state.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

String getBaseDescription(state, action) {
  return "test reducer with ${state.runtimeType} state and ${action.runtimeType} action : ";
}

void testStatusNone<S>(
  S state,
  AsyncAction action,
  Function reducer,
  AsyncStatus Function(S) statusGetter,
) {
  String description = getBaseDescription(state, action);

  test(description + "none satus", () {
    S newState = reducer(state, action);
    AsyncStatus oldAsyncState = statusGetter(state);
    AsyncStatus newAsyncState = statusGetter(newState);
    expect(identical(oldAsyncState, newAsyncState), true);
  });
}

void testStatusFetching<S>(
  S state,
  AsyncAction action,
  Function reducer,
  AsyncStatus Function(S) statusGetter,
) {
  String description = getBaseDescription(state, action);

  test(description + "fetching satus", () {
    action.status = RequestStatus.fetching;
    S newState = reducer(state, action);
    AsyncStatus oldAsyncState = statusGetter(state);
    AsyncStatus newAsyncState = statusGetter(newState);
    expect(identical(oldAsyncState, newAsyncState), false);
    expect(newAsyncState.isFetching, true);
    expect(newAsyncState.errors, null);
  });
}

void testStatusError<S>(
  S state,
  AsyncAction action,
  Function reducer,
  AsyncStatus Function(S) statusGetter,
) {
  String description = getBaseDescription(state, action);

  test(description + "error satus", () {
    action.status = RequestStatus.error;
    action.errors = ApiErrors.fromJson([]);
    S newState = reducer(state, action);
    AsyncStatus oldAsyncState = statusGetter(state);
    AsyncStatus newAsyncState = statusGetter(newState);
    expect(identical(oldAsyncState, newAsyncState), false);
    expect(newAsyncState.hasError, true);
    expect(newAsyncState.errors, []);
  });
}

void testStatusDone<S>(
  S state,
  AsyncAction action,
  Function reducer,
  AsyncStatus Function(S) statusGetter,
) {
  String description = getBaseDescription(state, action);

  test(description + "done satus", () {
    action.status = RequestStatus.done;
    action.errors = null;
    S newState = reducer(state, action);
    runTestStatusExpectations(state, newState, statusGetter);
  });
}

void runTestStatusExpectations<S>(S oldState, S newState, AsyncStatus Function(S) statusGetter) {
  AsyncStatus oldAsyncState = statusGetter(oldState);
  AsyncStatus newAsyncState = statusGetter(newState);
  expect(identical(oldAsyncState, newAsyncState), false);
  expect(newAsyncState.isDone, true);
  expect(newAsyncState.errors, null);
}

void testStateDone<S, R extends ApiResponse>(
  S state,
  AsyncAction<R> action,
  Function reducer,
  AsyncState<R> Function(S) stateGetter,
  R apiResponse,
) {
  String description = getBaseDescription(state, action);

  test(description + "done satus", () {
    action.status = RequestStatus.done;
    action.errors = null;
    action.data = apiResponse;
    S newState = reducer(state, action);
    runTestStatusExpectations(state, newState, stateGetter);

    AsyncState newAsyncState = stateGetter(newState);
    expect(newAsyncState.data, apiResponse);
  });
}

void testStatus<S>(
  S state,
  AsyncAction action,
  Function reducer,
  AsyncStatus Function(S) statusGetter,
) {
  testStatusNone(state, action, reducer, statusGetter);
  testStatusFetching(state, action, reducer, statusGetter);
  testStatusError(state, action, reducer, statusGetter);
  testStatusDone(state, action, reducer, statusGetter);
}

void testState<S, R extends ApiResponse>(
  S state,
  AsyncAction<R> action,
  Function reducer,
  AsyncState<R> Function(S) stateGetter,
  R apiResponse,
) {
  testStatusNone(state, action, reducer, stateGetter);
  testStatusFetching(state, action, reducer, stateGetter);
  testStatusError(state, action, reducer, stateGetter);
  testStateDone(state, action, reducer, stateGetter, apiResponse);
}
