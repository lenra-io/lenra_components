import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';
import 'package:redux/redux.dart';

abstract class AsyncStatusModel<A extends AsyncAction> {
  @protected
  final Store<AppState> store;
  const AsyncStatusModel(this.store);

  // To implement on subclass
  AsyncStatus get status;
  A createAction([ApiRequest body]);

  ApiErrors get errors {
    return status.errors;
  }

  void fetchData({bool force = false, ApiRequest body}) {
    if (force || !status.isFetching) {
      store.dispatch(createAction(body));
    }
  }
}
