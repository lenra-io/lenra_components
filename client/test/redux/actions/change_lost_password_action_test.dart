import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/change_lost_password_action.dart';

void main() {
  test('ChangeLostPasswordAction tests', () {
    ChangeLostPasswordAction action =
        ChangeLostPasswordAction(ChangeLostPasswordRequest("code", "email", "password", "password"));
    expect(action is AsyncAction, true);
  });
}
