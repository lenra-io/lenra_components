import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_status_sticker.dart';
import 'package:lenra_components/lenra_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'LenraStatusSticker',
        home: MyLenraStatusSticker(),
      ),
    );
  }
}

class MyLenraStatusSticker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyLenraStatusStickerState();
}

class _MyLenraStatusStickerState extends State<MyLenraStatusSticker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LenraStatusSticker'),
      ),
      body: Center(
        child: LenraColumn(
          children: [
            LenraRow(
              children: [
                LenraStatusSticker(color: LenraColorThemeData.LENRA_CUSTOM_GREEN),
                Text("OK"),
              ],
            ),
            LenraRow(
              children: [
                LenraStatusSticker(color: Colors.orange),
                Text("In Progress"),
              ],
            ),
            LenraRow(
              children: [
                LenraStatusSticker(color: LenraColorThemeData.LENRA_CUSTOM_RED),
                Text("Error"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
