import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/reducers/app_reducer.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

import '../actions/fake_action.dart';

void main() {
  test('app reducer, nothing change if the action is not used', () {
    AppState appState = AppState();
    AppState newAppState = appStateReducer(appState, FakeAction());

    expect(identical(appState, newAppState), false);
    expect(
      identical(appState.authState, newAppState.authState),
      true,
    );
    expect(
      identical(appState.applicationState, newAppState.applicationState),
      true,
    );
  });
}
