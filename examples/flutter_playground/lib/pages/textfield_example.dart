// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class TextfieldExample extends StatefulWidget {
  const TextfieldExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextfieldExampleState();
}

class _TextfieldExampleState extends State<TextfieldExample> {
  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      spacing: 5,
      children: [
        LenraTextField(
          label: "size small + disabled",
          disabled: true,
          size: LenraComponentSize.small,
        ),
        LenraTextField(
          label: "size medium + obscure text",
          obscure: true,
          size: LenraComponentSize.medium,
        ),
        LenraTextField(
          label: "size large + hintText",
          hintText: "Hint Text",
          size: LenraComponentSize.large,
        ),
        LenraTextField(
          label: "size default + minLines = maxLines ",
          minLines: 3,
          maxLines: 5,
        ),
        LenraTextField(
          label: "error + errorMessage",
          errorMessage: "errorMessage",
          error: true,
        )
      ],
    );
  }
}
