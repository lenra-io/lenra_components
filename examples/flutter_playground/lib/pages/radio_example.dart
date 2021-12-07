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
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 1,
              groupValue: 2,
              onPressed: (value) {},
            ),
            const Text("Basic"),
          ],
        ),
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 1,
              groupValue: 1,
              onPressed: (value) {},
            ),
            const Text("Selected"),
          ],
        ),
        const LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 1,
              groupValue: 2,
              onPressed: null,
            ),
            Text("Disabled"),
          ],
        ),
        const LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 1,
              groupValue: 1,
              onPressed: null,
            ),
            Text("Disabled selected"),
          ],
        ),
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 1,
              groupValue: groupValue,
              onPressed: (value) {
                setState(() {
                  groupValue = 1;
                });
              },
            ),
            const Text("Interactive 1"),
          ],
        ),
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 2,
              groupValue: groupValue,
              onPressed: (value) {
                setState(() {
                  groupValue = 2;
                });
              },
            ),
            const Text("Interactive 2"),
          ],
        ),
        LenraFlex(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraRadio(
              value: 3,
              groupValue: groupValue,
              onPressed: (value) {
                setState(() {
                  groupValue = 3;
                });
              },
            ),
            const Text("Interactive 3"),
          ],
        ),
      ],
    );
  }
}
