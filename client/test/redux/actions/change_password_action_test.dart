import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/change_password_action.dart';

void main() {
  test('ChangePasswordAction tests', () {
    ChangePasswordAction action = ChangePasswordAction(ChangePasswordRequest("oldpassword", "password", "password"));
    expect(action is AsyncAction, true);
  });
}
