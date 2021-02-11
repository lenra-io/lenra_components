import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';

void main() {
  test('to json', () {
    LoginRequest loginRequest = LoginRequest("email", "password");
    Map<String, dynamic> json = jsonDecode(jsonEncode(loginRequest));
    expect(loginRequest is ApiRequest, true);
    expect(json["email"], "email");
    expect(json["password"], "password");
  });
}
