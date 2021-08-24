import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'LenraMenu',
        home: MyLenraMenu(),
      ),
    );
  }
}

class MyLenraMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyLenraMenuState();
}

class _MyLenraMenuState extends State<MyLenraMenu> {
  List<bool> selectedItems = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LenraMenu'),
      ),
      body: LenraColumn(
        children: [
          // Basic LenraMenu
          LenraMenu(
            items: [
              LenraMenuItem(
                text: "menu item",
                onPressed: () => {},
              ),
              LenraMenuItem(
                text: "selected menu item",
                isSelected: true,
                onPressed: () => {},
              ),
            ],
          ),
          // Constrained LenraMenu
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: LenraMenu(
              items: [
                LenraMenuItem(
                  text: "menu item",
                  onPressed: () => {},
                ),
                LenraMenuItem(
                  text: "selected menu item",
                  isSelected: true,
                  onPressed: () => {},
                ),
              ],
            ),
          ),
          // Interactive LenraMenu
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: LenraMenu(
              items: [
                LenraMenuItem(
                  text: "Coffee",
                  isSelected: selectedItems[0],
                  onPressed: () => {
                    setState(() => {selectedItems[0] = !selectedItems[0]})
                  },
                ),
                LenraMenuItem(
                  text: "Water",
                  isSelected: selectedItems[1],
                  onPressed: () => {
                    setState(() => {selectedItems[1] = !selectedItems[1]})
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}