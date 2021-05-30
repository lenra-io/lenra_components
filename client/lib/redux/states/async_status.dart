import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

class AsyncStatus {
  final List<Function(AsyncStatus)> _listeners = [];
  final RequestStatus status;
  final ApiErrors errors;

  AsyncStatus({this.status = RequestStatus.none, this.errors});

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
    return _copyAndCallListeners(AsyncStatus(
      status: RequestStatus.fetching,
      errors: this.errors,
    ));
  }

  AsyncStatus copyDone() {
    return _copyAndCallListeners(AsyncStatus(
      status: RequestStatus.done,
      errors: null,
    ));
  }

  AsyncStatus copyError(ApiErrors errors) {
    return _copyAndCallListeners(AsyncStatus(
      status: RequestStatus.error,
      errors: errors,
    ));
  }

  AsyncStatus _copyAndCallListeners(AsyncStatus target) {
    target._listeners.addAll(this._listeners);
    if (target.isDone || target.hasError) {
      List.from(target._listeners).forEach((listener) {
        listener(target);
      });
    }
    return target;
  }

  Future<AsyncStatus> wait() {
    var completer = Completer<AsyncStatus>();
    Function(AsyncStatus) listener;
    listener = (AsyncStatus status) {
      completer.complete(status);
      status._listeners.remove(listener);
    };
    this._listeners.add(listener);
    return completer.future;
  }

  Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "errors": errors != null ? jsonEncode(errors) : null,
      };
}

@immutable
class AsyncState<T extends ApiResponse> extends AsyncStatus {
  final T data;

  AsyncState({status: RequestStatus.none, errors, this.data}) : super(errors: errors, status: status);

  @override
  AsyncState<T> reducer(AsyncAction action) {
    if (action.isFetching) return this.copyFetching();
    if (action.isDone) return this.copyDoneData(action.data);
    if (action.isError) return this.copyError(action.errors);

    return this;
  }

  @override
  AsyncState<T> copyFetching() {
    return _copyAndCallListeners(AsyncState<T>(
      status: RequestStatus.fetching,
      errors: this.errors,
    ));
  }

  AsyncState<T> copyDoneData(T data) {
    return _copyAndCallListeners(AsyncState<T>(
      status: RequestStatus.done,
      data: data,
      errors: null,
    ));
  }

  @override
  AsyncState<T> copyError(ApiErrors errors) {
    return _copyAndCallListeners(AsyncState<T>(
      status: RequestStatus.error,
      errors: errors,
    ));
  }

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "data": this.data != null ? jsonEncode(data) : null,
    });
}
