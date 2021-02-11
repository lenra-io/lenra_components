import 'package:fr_lenra_client/redux/reducers/application_reducer.dart';
import 'package:fr_lenra_client/redux/reducers/auth_reducer.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    authState: authStateReducer(state.authState, action),
    applicationState: applicationsReducer(state.applicationState, action),
  );
}
