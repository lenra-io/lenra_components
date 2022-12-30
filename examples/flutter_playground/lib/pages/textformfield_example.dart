// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class TextFormFieldExample extends StatefulWidget {
  const TextFormFieldExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<TextFormFieldExample> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      spacing: 5,
      children: [
        LenraTextFormField(
          label: "TextFormField with error when text is 'text'",
          errorMessage: errorMessage,
          onChanged: (value) {
            if (value == "text") {
              setState(() {
                errorMessage = "text not allowed";
              });
            } else {
              setState(() {
                errorMessage = null;
              });
            }
          },
        ),
      ],
    );
  }
}
