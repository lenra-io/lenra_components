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
    return Center(
      child: LenraFlex(
        direction: Axis.horizontal,
        children: [
          LenraCheckbox(label: "Basic", value: false, onPressed: () {}),
          LenraCheckbox(label: "Disabled", disabled: true, value: true, onPressed: () {}),
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
    );
  }
}
