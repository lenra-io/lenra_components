import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/backoffice/activation_code_page.dart';
import 'package:fr_lenra_client/components/page/backoffice/create_first_project_page.dart';
import 'package:fr_lenra_client/components/page/backoffice/overview_page.dart';
import 'package:fr_lenra_client/components/page/backoffice/settings_page.dart';
import 'package:fr_lenra_client/components/page/backoffice/welcome_dev_page.dart';
import 'package:fr_lenra_client/components/page/change_lost_password_page.dart';
import 'package:fr_lenra_client/components/page/change_password_confirmation_page.dart';
import 'package:fr_lenra_client/components/page/home_page.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page_container.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/profile_page.dart';
import 'package:fr_lenra_client/components/page/recovery_page.dart';
import 'package:fr_lenra_client/components/page/register_page.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/navigation/authorized_guard.dart';
import 'package:fr_lenra_client/navigation/custom_route_builder.dart';
import 'package:fr_lenra_client/navigation/first_app_guard.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/navigation/route_data.dart';

class LenraNavigator {
  static const String HOME_ROUTE = "/";
  static const String LOGIN_ROUTE = "/login";
  static const String REGISTER_ROUTE = "/register";
  static const String PROFILE_ROUTE = "/profile";
  static const String LOST_PASSWORD_ROUTE = "/lost";
  static const String CHANGE_LOST_PASSWORD_ROUTE = "/change-lost";
  static const String CHANGE_PASSWORD_CONFIRMATION_ROUTE = "/change-confirmation";
  static const String STORE_ROUTE = "/store";
  static const String APP_ROUTE = "/app/:appName";
  static String buildAppRoute(String appName) => "/app/$appName";
  static const String VALIDATION_DEV_ROUTE = "/validation-dev";
  static const String WELCOME = "/welcome";
  static const String FIRST_PROJECT = "/first-project";
  static const String SETTINGS = "/settings";

  static String currentPath;

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static final Map<String, _RouteMapper> routes = {}
    ..addAll(authRoutes)
    ..addAll(Config.instance.application == Application.app ? appRoutes : devRoutes);

  static final Map<String, _RouteMapper> authRoutes = {
    CHANGE_LOST_PASSWORD_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.notLoggedIn],
      builder: (Map<String, String> params) => ChangeLostPasswordPage(),
    ),
    LOST_PASSWORD_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.notLoggedIn],
      builder: (Map<String, String> params) => RecoveryPage(),
    ),
    CHANGE_PASSWORD_CONFIRMATION_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.notLoggedIn],
      builder: (Map<String, String> params) => ChangePasswordConfirmationPage(),
    ),
    PROFILE_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.loggedIn],
      builder: (Map<String, String> params) => ProfilePage(),
    ),
    LOGIN_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.notLoggedIn],
      builder: (Map<String, String> params) => LoginPage(),
    ),
    REGISTER_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.notLoggedIn],
      builder: (Map<String, String> params) => RegisterPage(),
    )
  };

  static final Map<String, _RouteMapper> appRoutes = {
    HOME_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.loggedIn],
      builder: (Map<String, String> params) => HomePage(),
    ),
    APP_ROUTE: _RouteMapper(
      guards: [AuthorizedGuard.loggedIn],
      builder: (Map<String, String> params) => LenraAppPageContainer(appName: params["appName"]),
    )
  };

  static final Map<String, _RouteMapper> devRoutes = {
    VALIDATION_DEV_ROUTE: _RouteMapper(
      guards: [
        AuthorizedGuard.loggedIn,
        AuthorizedGuard.isNotDev,
      ],
      builder: (Map<String, String> params) => ActivationCodePage(),
    ),
    WELCOME: _RouteMapper(
      guards: [
        AuthorizedGuard.loggedIn,
        AuthorizedGuard.isDev,
        FirstAppGuard(
          hasApplication: false,
        ),
      ],
      builder: (Map<String, String> params) => WelcomeDevPage(),
    ),
    FIRST_PROJECT: _RouteMapper(
      guards: [
        AuthorizedGuard.loggedIn,
        AuthorizedGuard.isDev,
        FirstAppGuard(
          hasApplication: false,
        ),
      ],
      builder: (Map<String, String> params) => CreateFirstProjectPage(),
    ),
    HOME_ROUTE: _RouteMapper(
      guards: [
        AuthorizedGuard.loggedIn,
        AuthorizedGuard.isDev,
        FirstAppGuard(),
      ],
      builder: (Map<String, String> params) => OverviewPage(),
    ),
    SETTINGS: _RouteMapper(
      guards: [
        AuthorizedGuard.loggedIn,
        AuthorizedGuard.isDev,
        FirstAppGuard(),
      ],
      builder: (Map<String, String> params) => SettingsPage(),
    ),
  };

  static Future<bool> _checkGuards(BuildContext context, List<PageGuard> guards) async {
    for (var guard in guards) {
      if (!await guard.check(context)) {
        return false;
      }
    }
    return true;
  }

  static RouteData _getRouteDataForRoutes(
    BuildContext context,
    List<String> currentRouteParts,
    String route,
    _RouteMapper routeMapper,
  ) {
    Map<String, String> params = Map();
    List<String> routeParts = route.split('/');
    if (routeParts.length != currentRouteParts.length) return null;
    for (int i = 0; i < routeParts.length; i++) {
      String routePart = routeParts[i];
      String currentRoutePart = currentRouteParts[i];

      if (routePart.startsWith(':')) {
        params[routePart.replaceFirst(':', '')] = currentRoutePart;
      } else if (routePart != currentRoutePart) return null;
    }
    if (routeMapper.guards.isNotEmpty) {
      return RouteData(
        (Map<String, String> pageParams) => FutureBuilder(
          future: _checkGuards(context, routeMapper.guards),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return routeMapper.builder(pageParams);
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        params,
      );
    }

    return RouteData(routeMapper.builder, params);
  }

  static RouteData _getFirstMatchingRoute(BuildContext context, String currentRoute) {
    List<String> currentRouteParts = currentRoute.split('/');
    for (MapEntry<String, _RouteMapper> entry in routes.entries) {
      RouteData _routeData = _getRouteDataForRoutes(context, currentRouteParts, entry.key, entry.value);
      if (_routeData != null) {
        return _routeData;
      }
    }
    return null;
  }

  static Route<dynamic> Function(RouteSettings) handleGenerateRoute(BuildContext context) {
    return (RouteSettings settings) {
      debugPrint("route: ${settings.name}");
      RouteData routeData = _getFirstMatchingRoute(context, settings.name);
      if (routeData == null) return null;
      currentPath = settings.name;
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, _a, _b) => routeData.builder(routeData.params),
        settings: settings,
      );
    };
  }
}

class _RouteMapper {
  final List<PageGuard> guards;
  final CustomRouteBuilder builder;

  _RouteMapper({this.guards = const [], @required this.builder});
}
