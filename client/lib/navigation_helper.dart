import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/change_lost_password_page.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page_container.dart';
import 'package:fr_lenra_client/components/page/lenra_components_showcase.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/profile_page.dart';
import 'package:fr_lenra_client/components/page/recovery_page.dart';
import 'package:fr_lenra_client/components/page/register_page.dart';
import 'package:fr_lenra_client/components/page/store_page.dart';
import 'package:fr_lenra_client/components/page/verifiying_code_page.dart';

typedef CustomRouteBuilder = Widget Function(BuildContext) Function(Map<String, String>);

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class RouteData {
  Map<String, String> params = Map();
  CustomRouteBuilder builder;

  final defaultParams = Map();

  void addParam(name, value) {
    params[name] = value;
  }

  RouteData(this.builder);
}

final Map<String, CustomRouteBuilder> routes = {
  ChangeLostPasswordPage.routeName: (Map<String, String> params) => (BuildContext context) => ChangeLostPasswordPage(),
  RecoveryPage.routeName: (Map<String, String> params) => (BuildContext context) => RecoveryPage(),
  ProfilePage.routeName: (Map<String, String> params) => (BuildContext context) => ProfilePage(),
  LoginPage.routeName: (Map<String, String> params) => (BuildContext context) => LoginPage(),
  VerifyingCodePage.routeName: (Map<String, String> params) => (BuildContext context) => VerifyingCodePage(),
  RegisterPage.routeName: (Map<String, String> params) => (BuildContext context) => RegisterPage(),
  StorePage.routeName: (Map<String, String> params) => (BuildContext context) => StorePage(),
  LenraAppPage.routeName: (Map<String, String> params) =>
      (BuildContext context) => LenraAppPageContainer(appName: params["appName"]),
  LenraComponentsShowcase.routeName: (Map<String, String> params) => (BuildContext context) => LenraComponentsShowcase()
};

RouteData getRouteDataForRoutes(
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
    bool isParam = routePart.startsWith(':');
    if (isParam) {
      routeData.addParam(routePart.replaceFirst(':', ''), currentRoutePart);
    } else if (routePart != currentRoutePart) {
      return null;
    }
  }

  return routeData;
}

RouteData getFirstMatchingRoute(String currentRoute) {
  List<String> currentRouteParts = currentRoute.split('/');
  for (MapEntry<String, CustomRouteBuilder> entry in routes.entries) {
    RouteData _routeData = getRouteDataForRoutes(currentRouteParts, entry.key, entry.value);
    if (_routeData != null) {
      return _routeData;
    }
  }
  return null;
}
