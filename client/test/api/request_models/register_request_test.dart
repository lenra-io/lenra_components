import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';

void main() {
  test('to json', () {
    RegisterRequest request = RegisterRequest(
      "email",
      "password",
      firstName: "firstName",
      lastName: "lastName",
    );
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(request is ApiRequest, true);
    expect(json["email"], "email");
    expect(json["first_name"], "firstName");
    expect(json["last_name"], "lastName");
    expect(json["password"], "password");
  });
}
