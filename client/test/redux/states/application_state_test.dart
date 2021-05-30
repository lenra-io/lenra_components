import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

void main() {
  test('application state default constructor', () {
    ApplicationState applicationState = ApplicationState();
    expect(applicationState.appListState != null, true);
  });

  test('application state copyWith', () {
    ApplicationState oldApplicationState = ApplicationState();
    ApplicationState newApplicationState = oldApplicationState.copyWith();
    expect(
      identical(oldApplicationState, newApplicationState),
      false,
    );
    expect(
      identical(oldApplicationState.appListState, newApplicationState.appListState),
      true,
    );

    newApplicationState = oldApplicationState.copyWith(appListState: AsyncState());

    expect(
      identical(oldApplicationState.appListState, newApplicationState.appListState),
      false,
    );
  });
}
