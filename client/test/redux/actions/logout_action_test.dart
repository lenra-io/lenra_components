import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/logout_action.dart';

void main() {
  test('LogoutAction tests', () {
    LogoutAction action = LogoutAction();
    expect(action is AsyncAction, true);
  });
}
