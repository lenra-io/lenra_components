import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';

void main() {
  test('RegisterAction tests', () {
    RegisterAction action =
        RegisterAction(RegisterRequest("email", "password", firstName: "firstName", lastName: "lastName"));
    expect(action is AsyncAction, true);
  });
}
