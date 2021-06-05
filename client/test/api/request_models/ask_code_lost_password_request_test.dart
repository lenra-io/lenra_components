import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';
import 'package:fr_lenra_client/api/request_models/ask_code_lost_password_request.dart';

void main() {
  test('to json', () {
    AskCodeLostPasswordRequest request = AskCodeLostPasswordRequest("email");
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(request is ApiRequest, true);
    expect(json["email"], "email");
  });
}
