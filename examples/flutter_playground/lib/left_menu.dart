import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key, required this.onMenuTapped, required this.currentMenu}) : super(key: key);

  final Function(String) onMenuTapped;
  final String currentMenu;

  static const flexExample = "Flex";
  static const flexExpandedExample = "FlexExpanded";
  static const toggleExample = "Toggle";
  static const menuExample = "menu";
  static const dropdownExample = "Dropdown";
  static const stickerExample = "Stickers";
  static const containerExample = "containerExample";
  static const radioExample = "radioExample";
  static const checkboxExample = "checkboxExample";
  static const buttonExample = "buttonExample";
  static const textFieldExample = "textFieldExample";
  static const wrapExample = "wrapExample";
  static const stackExample = "stackExample";
  static const overlayEntryExample = "overlayEntryExample";
  static const sliderExample = "sliderExample";

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
        createMenu(context, 'Flex Examples', flexExample),
        createMenu(context, 'Flex with Expanded', flexExpandedExample),
        createMenu(context, 'Toggle Examples', toggleExample),
        createMenu(context, 'Menu Examples', menuExample),
        createMenu(context, 'Dropdown Examples', dropdownExample),
        createMenu(context, 'Stickers Examples', stickerExample),
        createMenu(context, 'Container Examples', containerExample),
        createMenu(context, 'Radio Examples', radioExample),
        createMenu(context, 'Checkbox Example', checkboxExample),
        createMenu(context, 'Button Examples', buttonExample),
        createMenu(context, 'Textfield Examples', textFieldExample),
        createMenu(context, 'Wrap Examples', wrapExample),
        createMenu(context, 'stackExample', stackExample),
        createMenu(context, 'overlayEntry Example', overlayEntryExample),
        createMenu(context, 'OverlayEntry Examples', overlayEntryExample),
        createMenu(context, 'Slider Examples', sliderExample),
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
