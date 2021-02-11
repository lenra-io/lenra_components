import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../fake_store.dart';

typedef ModelCreator<T> = T Function(Store<AppState>);

void testModelAction<M extends AsyncStatusModel, A extends AsyncAction>(
    ModelCreator<M> modelCreator,
    {ApiRequest body}) {
  int reducerCallCount = 0;
  Function testReducer = (AppState state, action) {
    reducerCallCount++;
    expect(action is A, true);
    return state;
  };
  M model = modelCreator(createFakeStore(fakeReducer: testReducer));
  model.fetchData(body: body);
  expect(reducerCallCount, 1);
}
