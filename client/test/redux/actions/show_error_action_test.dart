import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/show_error_action.dart';

void main() {
  test('ShowErrorAction tests', () {
    var errors = ApiErrors.fromJson([
      {"code": 42, "message": "mon erreur"}
    ]);
    ShowErrorAction action = ShowErrorAction(errors);
    expect(action is Action, true);
    expect(action.errors, errors);
  });

  test('ShowErrorAction tests toJson', () {
    var errors = ApiErrors.fromJson([
      {"code": 42, "message": "mon erreur"}
    ]);
    ShowErrorAction action = ShowErrorAction(errors);
    expect(jsonEncode(action), '{"errors":"[{\\"message\\":\\"mon erreur\\",\\"code\\":42}]"}');
  });
}
