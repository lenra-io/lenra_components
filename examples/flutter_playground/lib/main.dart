import 'package:flutter/material.dart';

import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import 'left_menu.dart';
import 'pages/dropdown_example.dart';
import 'pages/my_lenra_menu.dart';
import 'pages/lenra_flex_expanded.dart';
import 'pages/flex_test.dart';
import 'pages/stack_example.dart';
import 'pages/toggle_test.dart';
import 'pages/button_example.dart';
import 'pages/checkbox_example.dart';
import 'pages/radio_example.dart';
import 'pages/status_sticker_example.dart';
import 'pages/container_example.dart';
import 'pages/textfield_example.dart';
import 'pages/wrap_example.dart';

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
                  currentMenu = newMenu;
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
      case LeftMenu.DROPDOWN_EXAMPLE:
        return DropdownExample();
      case LeftMenu.STICKER_EXAMPLE:
        return StatusStickerExample();
      case LeftMenu.containerExample:
        return ContainerExample();
      case LeftMenu.radioExample:
        return const RadioExample();
      case LeftMenu.checkboxExample:
        return const CheckboxExample();
      case LeftMenu.buttonExample:
        return const ButtonExample();
      case LeftMenu.textFieldExample:
        return const TextFieldExample();
      case LeftMenu.wrapExample:
        return const WrapExample();
      case LeftMenu.stackExample:
        return const StackExample();
    }
    return const Text("N/A");
  }
}
