import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/models/app_socket_model.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/models/build_model.dart';
import 'package:fr_lenra_client/models/store_model.dart';
import 'package:fr_lenra_client/models/user_application_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:provider/provider.dart';

class Lenra extends StatelessWidget {
  Lenra({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeData = LenraThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>(create: (context) => AuthModel()),
        ChangeNotifierProvider<BuildModel>(create: (context) => BuildModel()),
        ChangeNotifierProvider<UserApplicationModel>(create: (context) => UserApplicationModel()),
        ChangeNotifierProvider<StoreModel>(create: (context) => StoreModel()),
        ChangeNotifierProxyProvider<AuthModel, AppSocketModel>(
          create: (context) => AppSocketModel(context.read<AuthModel>()),
          update: (_, authModel, lenraSocketModel) {
            if (lenraSocketModel == null) return AppSocketModel(authModel);
            return lenraSocketModel..update(authModel);
          },
        ),
      ],
      builder: (BuildContext context, _) => LenraTheme(
        themeData: themeData,
        child: MaterialApp(
          title: 'Lenra',
          navigatorKey: LenraNavigator.navigatorKey,
          onGenerateInitialRoutes: (initialRoute) =>
              [LenraNavigator.handleGenerateRoute(RouteSettings(name: initialRoute))],
          onGenerateRoute: LenraNavigator.handleGenerateRoute,
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: themeData.lenraTextThemeData.bodyText),
          ),
        ),
      ),
    );
  }
}
