import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import 'left_menu.dart';
import 'pages/flex_test.dart';
import 'pages/lenra_flex_expanded.dart';
import 'pages/lenra_styled_container_test.dart';
import 'pages/toggle_test.dart';
import 'pages/my_lenra_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var currentMenu = LeftMenu.FLEX_EXAMPLE;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LenraTheme(
        child: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: LeftMenu(
              currentMenu: currentMenu,
              onMenuTapped: (newMenu) {
                setState(() {
                  this.currentMenu = newMenu;
                });
              },
            ),
          ),
          body: buildBody(),
        ),
        themeData: LenraThemeData(),
      ),
    );
  }

  Widget buildBody() {
    switch (currentMenu) {
      case LeftMenu.FLEX_EXAMPLE:
        return FlexTest();
      case LeftMenu.FLEX_EXPANDED_EXAMPLE:
        return LenraFlexExpanded();
      case LeftMenu.TOGGLE_EXAMPLE:
        return ToggleTest();
      case LeftMenu.MENU_EXAMPLE:
        return MyLenraMenu();
      case LeftMenu.STYLED_CONTAINER_EXAMPLE:
        return LenraStyledContainerTest();
    }
    return Text("N/A");
  }
}