import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';

class LenraCheckboxPage extends StatefulWidget {
  const LenraCheckboxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LenraCheckboxPageState();
  }
}

class _LenraCheckboxPageState extends State<LenraCheckboxPage> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1,
        child: LenraFlex(
          direction: Axis.horizontal,
          children: [
            LenraCheckbox(label: "Basic", value: false, onChanged: (e) {}),
            LenraCheckbox(label: "Disabled", disabled: true, value: true, onChanged: (e) {}),
            LenraCheckbox(
                label: "Interactive",
                value: value,
                onChanged: (e) {
                  setState(() {
                    value = !value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
