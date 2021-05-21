import 'dart:convert';

import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';

enum RequestStatus { fetching, done, error, none }

/// The action to execute an asynchronous request
abstract class AsyncAction<T extends ApiResponse> extends Action {
  Future<T> Function() future;
  RequestStatus status;
  ApiErrors errors;
  T data;
  bool isRetry;

  /// Creates an AsyncAction
  ///
  /// The AsyncAction takes a [Future] in the [future] parameter which will be the future to execute
  AsyncAction({this.future, this.status = RequestStatus.none, this.errors, this.data, this.isRetry = false});

  bool get isFetching {
    return status == RequestStatus.fetching;
  }

  bool get isDone {
    return status == RequestStatus.done;
  }

  bool get isError {
    return status == RequestStatus.error;
  }

  Map<String, dynamic> toJson() => {
        "future": future.toString(),
        "status": status.toString(),
        "errors": errors != null ? jsonEncode(errors) : null,
        "data": data != null ? data.toJson() : null,
        "isRetry": isRetry,
      };
}
