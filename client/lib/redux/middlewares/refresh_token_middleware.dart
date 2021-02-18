import 'package:fr_lenra_client/page/login_page.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/refresh_token_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

/// This middleware handles the [RefreshTokenAction] action.
void refreshTokenMiddleware(
  Store<AppState> store,
  AsyncAction action,
  NextDispatcher next,
) async {
  if (action is RefreshTokenAction) {
    handleRefreshTokenAction(store, action, next);
  } else if (action.isError && action.errors.has401()) {
    // ONLY if the action is on error state AND there is a 401 error in any of the error object,
    // then that means the access_token is whether expired or invalid/absent.
    handle401AsyncAction(store, action, next);
  } else {
    next(action);
  }
}

void handle401AsyncAction(
  Store<AppState> store,
  AsyncAction action,
  NextDispatcher next,
) {
  if (action.isRetry) {
    // Seconde try failed. access_token is invalid. We stop there and next the action.
    next(action);
  } else {
    // End of first try. access token is invalid but we can try to refresh it and retry.
    // We do NOT next the action (it will not be handle by reducer.)
    // We set the isRetry flag to True to avoid infinite retry loop.
    next(action);
    action.isRetry = true;
    store.dispatch(RefreshTokenAction(action));
  }
}

void handleRefreshTokenAction(
  Store<AppState> store,
  RefreshTokenAction action,
  NextDispatcher next,
) {
  if (action.isError) {
    // The refresh token API returned an error. That means the refresh token is invalid (or at lease we can't get a proper access token.)
    // We redirect the user to the connexion page.
    store.dispatch(PushRouteAction(LoginPage.routeName, removeStack: true));
    next(action);
  } else if (action.isDone) {
    // We got a new refresh token. First Next the action for the reducer to save the token
    next(action);
    // Then we can retry the previous action.
    store.dispatch(action.actionToRetry);
  } else {
    next(action);
  }
}
