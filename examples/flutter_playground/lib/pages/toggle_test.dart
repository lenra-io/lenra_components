import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class ToggleTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToggleTestState();
  }
}

class _ToggleTestState extends State<ToggleTest> {
  bool toggleValue = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1,
        child: LenraFlex(
          children: [
            LenraToggle(
              label: "First toggle",
              value: this.toggleValue,
              onPressed: () {
                setState(() {
                  this.toggleValue = !this.toggleValue;
                });
              },
            ),
            LenraToggle(
              label: "Second toggle",
              value: this.toggleValue,
              onPressed: () {
                setState(() {
                  this.toggleValue = !this.toggleValue;
                });
              },
            ),
            LenraToggle(
              label:
                  "This is a very long text that has absolutely no utility apart to test the utility of a very long text",
              value: this.toggleValue,
              onPressed: () {
                setState(() {
                  this.toggleValue = !this.toggleValue;
                });
              },
              disabled: true,
            ),
            LenraToggle(
              label: "Disabled & activated by default",
              value: !toggleValue,
              disabled: true,
              onPressed: () {},
            ),
          ],
          direction: Axis.horizontal,
        ),
      ),
    );
  }
}
