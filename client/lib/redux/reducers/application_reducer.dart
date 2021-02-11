import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';
import 'package:redux/redux.dart';

Reducer<ApplicationState> applicationsReducer = combineReducers([
  TypedReducer<ApplicationState, FetchApplicationsAction>(handleFetchApplicationsAction),
]);

ApplicationState handleFetchApplicationsAction(
    ApplicationState state, FetchApplicationsAction action) {
  return state.copyWith(
    appListState: state.appListState.reducer(action),
  );
}
