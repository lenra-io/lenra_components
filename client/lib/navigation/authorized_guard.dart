import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/refresh_token_action.dart';
import 'package:fr_lenra_client/redux/store.dart';

class AuthorizedGuard extends PageGuard {
  static final AuthorizedGuard notLoggedIn = AuthorizedGuard(roles: [], ifUnauthorized: _toHome);
  static final AuthorizedGuard loggedIn = AuthorizedGuard();
  static final AuthorizedGuard isDev = AuthorizedGuard(roles: _devOrMore, ifUnauthorized: _becomeDev);
  static final AuthorizedGuard isNotDev = AuthorizedGuard(
      roles: _getNotDevRoles(),
      ifUnauthorized: (_) {
        //Ne devrait pas arriver
      });
  static const _devOrMore = [UserRole.admin, UserRole.dev];
  final List<UserRole> roles;
  final Function(BuildContext) ifUnauthorized;

  AuthorizedGuard({
    this.roles = UserRole.values,
    this.ifUnauthorized = _refreshToken,
  }) : super(
          isAuthorized: (context) async {
            AuthResponse authResponse = LenraStore.getStore().state.authState.authResponse;
            if (roles.isEmpty) return authResponse?.accessToken == null;
            return authResponse != null &&
                authResponse.accessToken != null &&
                authResponse.user != null &&
                (roles.contains(authResponse.user.role));
          },
          ifUnauthorized: ifUnauthorized,
        );

  static void _refreshToken(context) {
    if (LenraStore.getStore().state.authState.refreshStatus.isNone) LenraStore.dispatch(RefreshTokenAction(null));
  }

  static void _becomeDev(_) {
    LenraStore.dispatch(PushRouteAction(LenraNavigator.VALIDATION_DEV_ROUTE));
  }

  static void _toHome(_) {
    LenraStore.dispatch(PushRouteAction(LenraNavigator.HOME_ROUTE));
  }

  static List<UserRole> _getNotDevRoles() {
    return List<UserRole>.from(UserRole.values.where((ur) => !_devOrMore.contains(ur)));
  }
}
