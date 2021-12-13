import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_text_field_style.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      spacing: 5,
      children: [
        LenraTextField(
          style: LenraTextFieldStyle(
            decoration: InputDecoration(
              labelText: "label",
              hintText: "hint",
              errorText: "error",
              helperText: "helper",
              prefixText: "prefix",
              suffixText: "suffix",
              counterText: "counter",
              semanticCounterText: "semanticCounter",
            ),
          ),
        ),
        LenraTextField(
          minLines: 2,
          maxLines: 5,
          maxLength: 800,
        ),
        LenraTextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (String? text) {
            print(text);
            if (text == null || text.isEmpty) {
              return 'Can\'t be empty';
            }
            if (text.length < 4) {
              return 'Too short';
            }
            return null;
          },
        ),
      ],
    );
  }
}
