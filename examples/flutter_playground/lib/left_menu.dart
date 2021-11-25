import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key, required this.onMenuTapped, required this.currentMenu}) : super(key: key);

  final Function(String) onMenuTapped;
  final String currentMenu;

  static const FLEX_EXAMPLE = "Flex";
  static const FLEX_EXPANDED_EXAMPLE = "FlexExpanded";
  static const TOGGLE_EXAMPLE = "Toggle";
  static const MENU_EXAMPLE = "menu";
  static const DROPDOWN_EXAMPLE = "Dropdown";
  static const STICKER_EXAMPLE = "Stickers";
  static const STYLED_CONTAINER_EXAMPLE = "styledContainer";
  static const radioExample = "radioExample";
  static const checkboxExample = "checkboxExample";
  static const buttonExample = "buttonExample";
  static const textFieldExample = "textFieldExample";
  static const wrapExample = "wrapExample";
  static const stackExample = "stackExample";

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Examples'),
        ),
        createMenu(context, 'Flex Examples', FLEX_EXAMPLE),
        createMenu(context, 'Flex with Expanded', FLEX_EXPANDED_EXAMPLE),
        createMenu(context, 'Toggle Examples', TOGGLE_EXAMPLE),
        createMenu(context, 'Menu Examples', MENU_EXAMPLE),
        createMenu(context, 'Dropdown Examples', DROPDOWN_EXAMPLE),
        createMenu(context, 'Stickers Examples', STICKER_EXAMPLE),
        createMenu(context, 'Styled Container Examples', STYLED_CONTAINER_EXAMPLE),
        createMenu(context, 'Radio Examples', radioExample),
        createMenu(context, 'Checkbox Example', checkboxExample),
        createMenu(context, 'Button Examples', buttonExample),
        createMenu(context, 'Textfield Examples', textFieldExample),
        createMenu(context, 'Wrap Examples', wrapExample),
        createMenu(context, 'stackExample', stackExample),
      ],
    );
  }

  Widget createMenu(BuildContext context, String title, String id) {
    return ListTile(
      title: Text(title, style: TextStyle(color: id == currentMenu ? Colors.grey : Colors.blue)),
      onTap: () {
        onMenuTapped(id);
        Navigator.of(context).pop();
      },
    );
  }
}
