import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckboxExampleState();
  }
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      mainAxisAlignment: MainAxisAlignment.center,
      fillParent: true,
      children: [
        LenraFlex(
          direction: Axis.vertical,
          fillParent: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LenraCheckbox(label: "Basic", value: false, onPressed: () {}),
            LenraCheckbox(
                label: "Disabled",
                disabled: true,
                value: true,
                onPressed: () {}),
            LenraCheckbox(
                label: "Interactive",
                value: value,
                onPressed: () {
                  setState(() {
                    value = !value;
                  });
                }),
          ],
        ),
      ],
    );
  }
}
