import 'dart:async';

import 'package:fr_lenra_client/api/response_models/api_errors.dart';

enum RequestStatus {
  none,
  fetching,
  done,
  error,
}

class Status<T> {
  // Set this to true prevent the request to redo if the data is already fetched (unless forced).
  bool hasCache;
  Status({this.hasCache = false});

  RequestStatus _requestStatus = RequestStatus.none;
  RequestStatus get requestStatus => _requestStatus;

  ApiErrors? _errors;
  ApiErrors? get errors => _errors;

  T? _cachedData;
  Future<T>? _currentFuture;
  //List<Completer<T>> _listeners = [];

  bool isFetching() => this.requestStatus == RequestStatus.fetching;
  bool isDone() => this.requestStatus == RequestStatus.done;
  bool hasError() => this.requestStatus == RequestStatus.error;
  bool isNone() => this.requestStatus == RequestStatus.none;

  Future<T> handle(Future<T> Function() futureBuilder, Function() notifyListeners,
      {bool force = false, bool allowParallel = false}) async {
    if (!allowParallel && this.isFetching() && this._currentFuture != null) return this._currentFuture!;
    if (this.hasCache && this.isDone() && !force) return this._cachedData!;
    try {
      this._requestStatus = RequestStatus.fetching;
      this._currentFuture = futureBuilder();
      this._errors = null;
      notifyListeners();
      this._cachedData = await this._currentFuture;
      this._requestStatus = RequestStatus.done;
      // _listeners.forEach((c) {
      //   c.complete(this._cachedData);
      // });
      // _listeners.clear();
      return this._cachedData!;
    } on ApiErrors catch (errors) {
      this._requestStatus = RequestStatus.error;
      this._errors = errors;
      // _listeners.forEach((c) {
      //   c.completeError(errors);
      // });
      // _listeners.clear();
      notifyListeners();
      return Future.error(errors);
    }
  }

  /*Future<T> wait() {
    if (this.isDone()) return Future.value(this._cachedData);
    if (this.hasError()) return Future.error(this._errors);
    var completer = Completer<T>();
    _listeners.add(completer);
    return completer.future;
  }*/
}
