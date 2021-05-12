import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/redux/actions/activation_code_action.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

void main() {
  test('ActivationCodeAction tests', () {
    ActivationCodeAction action = ActivationCodeAction(ActivationCodeRequest("code"));
    expect(action is AsyncAction, true);
  });
}
