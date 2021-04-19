import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/recovery_action.dart';

void main() {
  test('RecoveryAction tests', () {
    RecoveryAction action = RecoveryAction(RecoveryRequest("email"));
    expect(action is AsyncAction, true);
  });
}
