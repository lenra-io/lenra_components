import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/navigation_helper.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

class Lenra extends StatelessWidget {
  final Store<AppState> store;
  Lenra({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Lenra Client',
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          RouteData routeData = getFirstMatchingRoute(settings.name);
          if (routeData == null) return null;
          return MaterialPageRoute(
            builder: routeData.builder(routeData.params),
            settings: settings,
          );
        },
        theme: ThemeData(
          brightness: SchedulerBinding.instance.window.platformBrightness,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
        ),
      ),
    );
  }
}
