import 'package:fr_lenra_client/page/store_page.dart';
import 'package:fr_lenra_client/page/verifiying_code_page.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
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

  if (action is RegisterAction && action.isDone) {
    store.dispatch(PushRouteAction(VerifyingCodePage.routeName, removeStack: true));
  }
  if ((action is VerifyCodeAction || action is LoginAction) && action.isDone) {
    store.dispatch(PushRouteAction(StorePage.routeName, removeStack: true));
  }
}
