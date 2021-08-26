import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_components/lenra_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'LenraDropdownButton',
        home: MyDropdownButton(),
      ),
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LenraMenu'),
      ),
      body: LenraColumn(
        children: [
          LenraDropdownButton(
            text: "Dropdown",
            child: IntrinsicWidth(
              child: LenraMenu(
                items: [
                  LenraMenuItem(
                    text: "MenuItem",
                    onPressed: () => {},
                  ),
                  LenraMenuItem(
                    text: "MenuItem2MenuItem2MenuItem2",
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
