import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';

class TextExample extends StatefulWidget {
  const TextExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextExampleState();
  }
}

class _TextExampleState extends State<TextExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LenraFlex(
        direction: Axis.vertical,
        spacing: 4,
        children: [
          LenraText(text: "Basic"),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            width: 60,
            child: LenraText(
              text: "This is a centered text.",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            width: 100,
            child: LenraText(
              text: "This is a justified text. This is a justified text.",
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
