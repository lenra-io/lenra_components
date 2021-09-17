import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      children: [
        LenraRadio(
          label: "Basic",
          value: 1,
          groupValue: 2,
          onChanged: (e) {},
        ),
        LenraRadio(
          label: "Selected",
          value: 1,
          groupValue: 1,
          onChanged: (e) {},
        ),
        LenraRadio(
          label: "Disabled",
          disabled: true,
          value: 1,
          groupValue: 2,
          onChanged: (e) {},
        ),
        LenraRadio(
          label: "Disabled selected",
          disabled: true,
          value: 1,
          groupValue: 1,
          onChanged: (e) {},
        ),
        LenraRadio(
          label: "Interactive 1",
          value: 1,
          groupValue: groupValue,
          onChanged: (int? e) {
            setState(() {
              groupValue = e!;
            });
          },
        ),
        LenraRadio(
          label: "Interactive 2",
          value: 2,
          groupValue: groupValue,
          onChanged: (int? e) {
            setState(() {
              groupValue = e!;
            });
          },
        ),
        LenraRadio(
          label: "Interactive 3",
          value: 3,
          groupValue: groupValue,
          onChanged: (int? e) {
            setState(() {
              groupValue = e!;
            });
          },
        ),
      ],
    );
  }
}
