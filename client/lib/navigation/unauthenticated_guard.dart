import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/store.dart';

class UnauthenticatedGuard extends PageGuard {
  UnauthenticatedGuard({@required Widget child})
      : super(
          child: child,
          isAuthorized: () {
            AuthResponse authResponse = LenraStore.getStore().state.authState.authResponse;
            return authResponse == null;
          },
          ifUnauthorized: () {
            LenraStore.dispatch(PushRouteAction(LenraNavigator.HOME_ROUTE));
          },
        );
}
