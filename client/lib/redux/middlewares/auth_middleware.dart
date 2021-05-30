import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/change_lost_password_action.dart';
import 'package:fr_lenra_client/redux/actions/change_password_action.dart';
import 'package:fr_lenra_client/redux/actions/logout_action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/recovery_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

/// This middleware handles authentication actions.
///
/// The [authMiddleware] checks whether the action is an auth action, for example if it corresponds to a [RegisterAction], doing the correct action accordingly.
void authMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  next(action);

  if (action is AsyncAction<AuthResponse> && action.isDone) {
    // TODO: réactiver la confirmation de compte
    /* if (store.state.authState.authResponse.user.role == "unverified_user") {
      store.dispatch(PushRouteAction(VerifyingCodePage.routeName, removeStack: true));
    } else */
    if (Config.instance.application == Application.dev &&
        store.state.authState.authResponse.user.role != UserRole.dev) {
      store.dispatch(PushRouteAction(LenraNavigator.VALIDATION_DEV_ROUTE, removeStack: true));
    } else {
      // rediriger vers la page à laquelle voulait accéder l'utilisateur.
      // Si il ne voulais pas accéder à une page particulière, rediriger vers la base : /
      String pageToRedirect = store.state.authState.redirectToRoute;
      if (pageToRedirect != null) store.dispatch(PushRouteAction(pageToRedirect, removeStack: true));
    }
  }
  if (action is LogoutAction && action.isDone) {
    store.dispatch(PushRouteAction(LenraNavigator.LOGIN_ROUTE, removeStack: true));
  }
  if (action is RecoveryAction && action.isDone) {
    store.dispatch(
        PushRouteAction(LenraNavigator.CHANGE_LOST_PASSWORD_ROUTE, arguments: action.email, removeStack: true));
  }
  if ((action is ChangePasswordAction || action is ChangeLostPasswordAction) && action.isDone) {
    store.dispatch(PushRouteAction(LenraNavigator.CHANGE_PASSWORD_CONFIRMATION_ROUTE, removeStack: true));
  }
}
