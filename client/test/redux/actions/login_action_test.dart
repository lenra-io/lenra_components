import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';

void main() {
  test('LoginAction tests', () {
    LoginAction action = LoginAction(LoginRequest("email", "password"));
    expect(action is AsyncAction, true);
  });
}
