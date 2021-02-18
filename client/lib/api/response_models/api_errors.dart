import 'dart:collection';

import 'package:fr_lenra_client/api/response_models/api_error.dart';

class ApiErrors extends ListBase<ApiError> {
  List<ApiError> _list;

  ApiErrors.connexionRefusedError() : _list = [ApiError.connexionRefusedError()];

  ApiErrors.fromJson(List<dynamic> json)
      : _list = List.from(json.map((e) => ApiError.fromJson(e as Map<String, dynamic>)));

  bool has401() {
    return _list.any((err) => err.is401());
  }

  //////////////////////////
  // List implementation ///
  //////////////////////////

  set length(int l) {
    this._list.length = l;
  }

  int get length => _list.length;

  ApiError operator [](int index) => _list[index];

  void operator []=(int index, ApiError value) {
    _list[index] = value;
  }

  @override
  String toString() {
    return _list.map((e) => e.toString()).join("\n");
  }
}
