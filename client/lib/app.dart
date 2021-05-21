import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/lenra_components/theme/base_material_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

class Lenra extends StatelessWidget {
  final Store<AppState> store;
  Lenra({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: LenraTheme(
        themeData: LenraThemeData(),
        child: MaterialApp(
          title: 'Lenra',
          navigatorKey: LenraNavigator.navigatorKey,
          onGenerateRoute: LenraNavigator.handleGenerateRoute,
          theme: baseMaterialThemeData,
        ),
      ),
    );
  }
}
