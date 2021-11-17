import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckboxExampleState();
  }
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool value = true;
  bool? triValue = true;

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
            LenraCheckbox(
              value: false,
              onPressed: (bool? v) {},
            ),
            const LenraCheckbox(
              value: true,
              onPressed: null,
            ),
            LenraCheckbox(
              value: value,
              onPressed: (bool? v) {
                setState(() {
                  value = !value;
                });
              },
            ),
            LenraCheckbox(
                value: triValue,
                tristate: true,
                onPressed: (bool? v) {
                  setState(() {
                    triValue = v;
                  });
                })
          ],
        ),
      ],
    );
  }
}
