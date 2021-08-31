import 'package:flutter/material.dart';
import 'package:flutter_playground/flex_test.dart';
import 'package:flutter_playground/left_menu.dart';
import 'package:flutter_playground/toggle_test.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

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
      case LeftMenu.TOGGLE_EXAMPLE:
        return ToggleTest();
    }
    return Text("N/A");
  }
}
