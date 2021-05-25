import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/backoffice/activation_code_page.dart';
import 'package:fr_lenra_client/components/page/backoffice/create_first_project_page.dart';
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
import 'package:fr_lenra_client/navigation/backoffice_guard.dart';
import 'package:fr_lenra_client/navigation/custom_route_builder.dart';
import 'package:fr_lenra_client/navigation/route_data.dart';
import 'package:fr_lenra_client/navigation/unauthenticated_guard.dart';

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

  static String currentPath;

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static final Map<String, CustomRouteBuilder> routes = {}
    ..addAll(authRoutes)
    ..addAll(Config.instance.application == Application.app ? appRoutes : devRoutes);

  static final Map<String, CustomRouteBuilder> authRoutes = {
    CHANGE_LOST_PASSWORD_ROUTE: (Map<String, String> params) => UnauthenticatedGuard(child: ChangeLostPasswordPage()),
    LOST_PASSWORD_ROUTE: (Map<String, String> params) => UnauthenticatedGuard(child: RecoveryPage()),
    CHANGE_PASSWORD_CONFIRMATION_ROUTE: (Map<String, String> params) =>
        UnauthenticatedGuard(child: ChangePasswordConfirmationPage()),
    PROFILE_ROUTE: (Map<String, String> params) => UnauthenticatedGuard(child: ProfilePage()),
    LOGIN_ROUTE: (Map<String, String> params) => UnauthenticatedGuard(child: LoginPage()),
    REGISTER_ROUTE: (Map<String, String> params) => UnauthenticatedGuard(child: RegisterPage())
  };

  static final Map<String, CustomRouteBuilder> appRoutes = {
    HOME_ROUTE: (Map<String, String> params) => AuthorizedGuard(child: HomePage()),
    APP_ROUTE: (Map<String, String> params) => AuthorizedGuard(child: LenraAppPageContainer(appName: params["appName"]))
  };

  static final Map<String, CustomRouteBuilder> devRoutes = {
    VALIDATION_DEV_ROUTE: (Map<String, String> params) => AuthorizedGuard(child: ActivationCodePage()),
    HOME_ROUTE: (Map<String, String> params) => AuthorizedGuard(child: HomePage()),
    WELCOME: (Map<String, String> params) => BackofficeGuard(
          child: WelcomeDevPage(),
          hasApplication: false,
        ),
    FIRST_PROJECT: (Map<String, String> params) => BackofficeGuard(
          child: CreateFirstProjectPage(),
          hasApplication: false,
        ),
  };

  static RouteData _getRouteDataForRoutes(
    List<String> currentRouteParts,
    String route,
    CustomRouteBuilder routeBuilder,
  ) {
    RouteData routeData = RouteData(routeBuilder);
    List<String> routeParts = route.split('/');
    if (routeParts.length != currentRouteParts.length) return null;
    for (int i = 0; i < routeParts.length; i++) {
      String routePart = routeParts[i];
      String currentRoutePart = currentRouteParts[i];

      if (routePart.startsWith(':')) {
        routeData.addParam(routePart.replaceFirst(':', ''), currentRoutePart);
      } else if (routePart != currentRoutePart) return null;
    }

    return routeData;
  }

  static RouteData _getFirstMatchingRoute(String currentRoute) {
    List<String> currentRouteParts = currentRoute.split('/');
    for (MapEntry<String, CustomRouteBuilder> entry in routes.entries) {
      RouteData _routeData = _getRouteDataForRoutes(currentRouteParts, entry.key, entry.value);
      if (_routeData != null) {
        return _routeData;
      }
    }
    return null;
  }

  static Route<dynamic> handleGenerateRoute(RouteSettings settings) {
    RouteData routeData = _getFirstMatchingRoute(settings.name);
    if (routeData == null) return null;
    currentPath = settings.name;
    return MaterialPageRoute(
      builder: (BuildContext context) => routeData.builder(routeData.params),
      settings: settings,
    );
  }
}
