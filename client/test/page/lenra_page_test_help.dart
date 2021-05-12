import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

import '../redux/fake_store.dart';

Widget createBaseTestWidgets(Widget child) {
  Store<AppState> store = createFakeStore();
  return StoreProvider<AppState>(
    store: store,
    child: LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        home: child,
      ),
    ),
  );
}
