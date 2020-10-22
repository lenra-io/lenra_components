import 'package:flutter/foundation.dart';

class LenraError extends Error {
  FlutterError _flutterError;

  LenraError(String message) {
    this._flutterError = FlutterError(message);
  }

  String get message => this._flutterError.toString();
  String toStringShort() => 'LenraError';
}
