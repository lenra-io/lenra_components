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
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/profile_page.dart';
import 'package:fr_lenra_client/components/page/recovery_page.dart';
import 'package:fr_lenra_client/components/page/register_page.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_controller.dart';
import 'package:fr_lenra_client/navigation/guard.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';

typedef CustomPageBuilder = Widget Function(Map<String, String>);

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

  static String currentRoute;

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static final Map<String, CustomPageBuilder> routes = {}
    ..addAll(authRoutes)
    ..addAll(Config.instance.application == Application.app ? appRoutes : devRoutes);

  static final Map<String, CustomPageBuilder> authRoutes = {
    CHANGE_LOST_PASSWORD_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangeLostPasswordPage(),
        ),
    LOST_PASSWORD_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RecoveryPage(),
        ),
    CHANGE_PASSWORD_CONFIRMATION_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: ChangePasswordConfirmationPage(),
        ),
    PROFILE_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: ProfilePage(),
        ),
    LOGIN_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: LoginPage(),
        ),
    REGISTER_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkUnauthenticated],
          child: RegisterPage(),
        )
  };

  static final Map<String, CustomPageBuilder> appRoutes = {
    HOME_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: HomePage(),
        ),
    APP_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated],
          child: LenraUiController(params["appName"]),
        )
  };

  static final Map<String, CustomPageBuilder> devRoutes = {
    VALIDATION_DEV_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [Guard.checkAuthenticated, Guard.checkIsNotDev],
          child: ActivationCodePage(),
        ),
    WELCOME: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkIsDev,
            Guard.checkNotHaveApp,
          ],
          child: WelcomeDevPage(),
        ),
    FIRST_PROJECT: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkIsDev,
            Guard.checkNotHaveApp,
          ],
          child: CreateFirstProjectPage(),
        ),
    HOME_ROUTE: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkIsDev,
            Guard.checkHaveApp,
          ],
          child: OverviewPage(),
        ),
    SETTINGS: (Map<String, String> params) => PageGuard(
          guards: [
            Guard.checkAuthenticated,
            Guard.checkIsDev,
            Guard.checkHaveApp,
          ],
          child: SettingsPage(),
        ),
  };

  static Widget _getPageForRoutes(
    List<String> currentRouteParts,
    String route,
    CustomPageBuilder routeBuilder,
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

    return routeBuilder(params);
  }

  static Widget _getFirstMatchingPage(String currentRoute) {
    List<String> currentRouteParts = currentRoute.split('/');
    for (MapEntry<String, CustomPageBuilder> entry in routes.entries) {
      Widget page = _getPageForRoutes(currentRouteParts, entry.key, entry.value);
      if (page != null) {
        return page;
      }
    }
    return null;
  }

  static Route<dynamic> handleGenerateRoute(RouteSettings settings) {
    debugPrint("route: ${settings.name}");
    currentRoute = settings.name;
    Widget page = _getFirstMatchingPage(settings.name);
    if (page == null) return null;
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, _a, _b) {
        return page;
      },
      settings: settings,
    );
  }
}
