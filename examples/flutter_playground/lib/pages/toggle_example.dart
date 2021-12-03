import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/theme/lenra_toggle_syle.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class ToggleExample extends StatefulWidget {
  const ToggleExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToggleExampleState();
  }
}

class _ToggleExampleState extends State<ToggleExample> {
  bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1,
        child: LenraFlex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LenraFlex(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Basic'),
                LenraToggle(
                  value: toggleValue,
                  onPressed: (newValue) {
                    setState(() {
                      toggleValue = newValue;
                    });
                  },
                ),
              ],
            ),
            LenraFlex(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Disabled'),
                LenraToggle(
                  value: toggleValue,
                  onPressed: null,
                ),
              ],
            ),
            LenraFlex(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Styled'),
                LenraToggle(
                  value: toggleValue,
                  onPressed: (v) {},
                  style: const LenraToggleStyle(
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.black,
                    hoverColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
