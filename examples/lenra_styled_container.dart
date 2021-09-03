import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import 'package:lenra_components/lenra_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'LenraStyledContainer',
        home: MyLenraStyledContainer(),
      ),
    );
  }
}

class MyLenraStyledContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyLenraStyledContainerState();
}

class _MyLenraStyledContainerState extends State<MyLenraStyledContainer> {
  List<bool> selectedItems = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LenraStyledContainer'),
      ),
      body: LenraColumn(
        children: [
          LenraStyledContainer(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Text("test"),
            ),
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: BoxShadow(
              offset: const Offset(2.0, 2.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
