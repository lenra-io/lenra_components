import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';

void main() {
  test('to json', () {
    ActivationCodeRequest request = ActivationCodeRequest("code");
    Map<String, dynamic> json = jsonDecode(jsonEncode(request));
    expect(request is ApiRequest, true);
    expect(json["code"], "code");
  });
}
