import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/text_example.dart';

import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import 'left_menu.dart';
import 'pages/dropdown_example.dart';
import 'pages/my_lenra_menu.dart';
import 'pages/lenra_flex_expanded.dart';
import 'pages/flex_test.dart';
import 'pages/overlay_entry_example.dart';
import 'pages/slider_example.dart';
import 'pages/stack_example.dart';
import 'pages/toggle_example.dart';
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
  var currentMenu = LeftMenu.flexExample;

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
      case LeftMenu.flexExample:
        return FlexTest();
      case LeftMenu.flexExpandedExample:
        return LenraFlexExpanded();
      case LeftMenu.toggleExample:
        return const ToggleExample();
      case LeftMenu.menuExample:
        return MyLenraMenu();
      case LeftMenu.dropdownExample:
        return DropdownExample();
      case LeftMenu.stickerExample:
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
      case LeftMenu.overlayEntryExample:
        return const OverlayEntryExample();
      case LeftMenu.sliderExample:
        return const SliderExample();
      case LeftMenu.textExample:
        return const TextExample();
    }
    return const Text("N/A");
  }
}
