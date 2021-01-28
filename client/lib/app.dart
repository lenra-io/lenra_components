import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fr_lenra_client/page/app_page.dart';
import 'package:fr_lenra_client/page/store_page.dart';

typedef CustomRouteBuilder = Widget Function(BuildContext) Function(Map<String, String>);

class _RouteData {
  Map<String, String> params = Map();
  CustomRouteBuilder builder;

  final defaultParams = Map();

  void addParam(name, value) {
    params[name] = value;
  }

  _RouteData(this.builder);
}

class Lenra extends StatelessWidget {
  Lenra({Key key}) : super(key: key);

  final Map<String, CustomRouteBuilder> routes = {
    StorePage.routeName: (Map<String, String> params) => (BuildContext context) => StorePage(),
    LenraAppPage.routeName: (Map<String, String> params) =>
        (BuildContext context) => LenraAppPage(appName: params["appName"]),
  };

  _RouteData getRouteDataForRoutes(
      List<String> currentRouteParts, String route, CustomRouteBuilder routeBuilder) {
    _RouteData routeData = _RouteData(routeBuilder);
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

  _RouteData getFirstMatchingRoute(String currentRoute) {
    List<String> currentRouteParts = currentRoute.split('/');
    for (MapEntry<String, CustomRouteBuilder> entry in routes.entries) {
      _RouteData _routeData = getRouteDataForRoutes(currentRouteParts, entry.key, entry.value);
      if (_routeData != null) {
        return _routeData;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lenra Client',
      onGenerateRoute: (RouteSettings settings) {
        _RouteData _routeData = getFirstMatchingRoute(settings.name);
        if (_routeData == null) return null;
        return MaterialPageRoute(
          builder: _routeData.builder(_routeData.params),
          settings: settings,
        );
      },
      theme: ThemeData(
        brightness: SchedulerBinding.instance.window.platformBrightness,
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
      ),
    );
  }
}
