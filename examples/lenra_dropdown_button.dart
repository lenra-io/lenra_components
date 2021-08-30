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
      body: Center(
        child: LenraColumn(
          children: [
            Text("A basic LenraDropdownButton"),
            LenraDropdownButton(
                text: "Basic",
                child: IntrinsicWidth(
                  child: LenraMenu(
                    items: [
                      LenraMenuItem(
                        text: "First",
                        onPressed: () => {},
                      ),
                      LenraMenuItem(
                        text: "Second",
                        onPressed: () => {},
                      ),
                    ],
                  ),
                )),
            Text("A LenraDropdownButton is automatically enabling scrolling when its menu content overflows"),
            LenraDropdownButton(
              text: "Scrolling Dropdown",
              child: IntrinsicWidth(
                child: LenraMenu(
                  items: List.filled(60, LenraMenuItem(text: "item", onPressed: () => {})),
                ),
              ),
            ),
            Text("Anything can be given as a child to LenraDropdownButton"),
            LenraDropdownButton(
              text: "custom child",
              child: Text(
                "custom",
                style: TextStyle(
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
