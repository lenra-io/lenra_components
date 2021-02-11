import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';

void main() {
  test('app state test default constructor', () {
    AppState appState = AppState();
    expect(appState.applicationState != null, true);
    expect(appState.authState != null, true);
  });

  test('app state copyWith', () {
    AppState oldAppState = AppState();
    AppState newAppState = oldAppState.copyWith(
      applicationState: ApplicationState(),
    );

    expect(identical(oldAppState, newAppState), false);
    expect(identical(oldAppState.authState, newAppState.authState), true);
    expect(identical(oldAppState.applicationState, newAppState.applicationState), false);
  });
}
