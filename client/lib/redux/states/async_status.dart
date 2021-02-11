import 'dart:convert';

import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

class AsyncStatus {
  final RequestStatus status;
  final ApiErrors errors;

  const AsyncStatus({this.status = RequestStatus.none, this.errors});

  AsyncStatus reducer(AsyncAction action) {
    if (action.isFetching) return this.copyFetching();
    if (action.isDone) return this.copyDone();
    if (action.isError) return this.copyError(action.errors);

    return this;
  }

  bool get hasError {
    return status == RequestStatus.error;
  }

  bool get isFetching {
    return status == RequestStatus.fetching;
  }

  bool get isDone {
    return status == RequestStatus.done;
  }

  bool get isNone {
    return status == RequestStatus.none;
  }

  bool get isNoneOrError {
    return this.isNone || this.hasError;
  }

  AsyncStatus copyFetching() {
    return AsyncStatus(
      status: RequestStatus.fetching,
      errors: this.errors,
    );
  }

  AsyncStatus copyDone() {
    return AsyncStatus(
      status: RequestStatus.done,
      errors: null,
    );
  }

  AsyncStatus copyError(ApiErrors errors) {
    return AsyncStatus(
      status: RequestStatus.error,
      errors: errors,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "errors": errors != null ? jsonEncode(errors) : null,
      };
}
