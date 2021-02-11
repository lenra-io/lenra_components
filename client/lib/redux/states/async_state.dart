import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

@immutable
class AsyncState<T extends ApiResponse> extends AsyncStatus {
  final T data;

  const AsyncState({status: RequestStatus.none, errors, this.data})
      : super(errors: errors, status: status);

  @override
  AsyncState<T> reducer(AsyncAction action) {
    if (action.isFetching) return this.copyFetching();
    if (action.isDone) return this.copyDoneData(action.data);
    if (action.isError) return this.copyError(action.errors);

    return this;
  }

  @override
  AsyncState<T> copyFetching() {
    return AsyncState(
      status: RequestStatus.fetching,
      errors: this.errors,
    );
  }

  AsyncState<T> copyDoneData(T data) {
    return AsyncState(
      status: RequestStatus.done,
      data: data,
      errors: null,
    );
  }

  @override
  AsyncState<T> copyError(ApiErrors errors) {
    return AsyncState(
      status: RequestStatus.error,
      errors: errors,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "errors": errors != null ? jsonEncode(errors) : null,
        "data": data != null ? jsonEncode(data) : null,
      };
}
