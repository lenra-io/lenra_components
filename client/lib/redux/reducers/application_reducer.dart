import 'package:fr_lenra_client/redux/actions/create_application_action.dart';
import 'package:fr_lenra_client/redux/actions/fetch_applications_action.dart';
import 'package:fr_lenra_client/redux/actions/fetch_user_applications_action.dart';
import 'package:fr_lenra_client/redux/states/application_state.dart';
import 'package:redux/redux.dart';

Reducer<ApplicationState> applicationsReducer = combineReducers([
  TypedReducer<ApplicationState, FetchApplicationsAction>(handleFetchApplicationsAction),
  TypedReducer<ApplicationState, FetchUserApplicationsAction>(handleFetchUserApplicationsAction),
  TypedReducer<ApplicationState, FetchUserApplicationsAction>(handleFetchUserApplicationsActionDone),
  TypedReducer<ApplicationState, CreateApplicationAction>(handleCreateApplication),
  TypedReducer<ApplicationState, CreateApplicationAction>(handleCreateApplicationDone),
]);

ApplicationState handleCreateApplicationDone(ApplicationState state, CreateApplicationAction action) {
  if (action.isDone) {
    return state.copyWith(
      userApplications: List.from(state.userApplications)..add(action.data.app),
    );
  }
  return state;
}

ApplicationState handleCreateApplication(ApplicationState state, CreateApplicationAction action) {
  return state.copyWith(
    createAppStatus: state.createAppStatus.reducer(action),
  );
}

ApplicationState handleFetchUserApplicationsAction(ApplicationState state, FetchUserApplicationsAction action) {
  return state.copyWith(
    fetchUserAppsStatus: state.fetchUserAppsStatus.reducer(action),
  );
}

ApplicationState handleFetchUserApplicationsActionDone(ApplicationState state, FetchUserApplicationsAction action) {
  if (action.isDone) {
    return state.copyWith(
      userApplications: action.data.apps,
    );
  }
  return state;
}

ApplicationState handleFetchApplicationsAction(ApplicationState state, FetchApplicationsAction action) {
  return state.copyWith(
    appListState: state.appListState.reducer(action),
  );
}
