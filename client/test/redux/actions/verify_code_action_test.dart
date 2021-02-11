import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';

void main() {
  test('VerifyCodeAction tests', () {
    VerifyCodeAction action = VerifyCodeAction(VerifyCodeRequest("code"));
    expect(action is AsyncAction, true);
  });
}
