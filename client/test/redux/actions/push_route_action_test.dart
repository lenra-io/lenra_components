import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';

void main() {
  test('PushRouteAction tests', () {
    PushRouteAction action =
        PushRouteAction("routeName", arguments: "arguments", removeStack: true);
    expect(action is Action, true);
    expect(action.routeName, "routeName");
    expect(action.arguments, "arguments");
    expect(action.removeStack, true);
  });
}
