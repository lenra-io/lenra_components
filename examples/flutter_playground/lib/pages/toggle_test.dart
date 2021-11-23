import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/theme/lenra_toggle_syle.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class ToggleTest extends StatefulWidget {
  const ToggleTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToggleTestState();
  }
}

class _ToggleTestState extends State<ToggleTest> {
  bool toggleValue = false;
  bool toggleValue1 = false;
  bool toggleValue2 = true;
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
                const Text('First Toggle'),
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
                const Text('Second Toggle'),
                LenraToggle(
                  value: toggleValue1,
                  onPressed: (newValue) {
                    setState(() {
                      toggleValue1 = newValue;
                    });
                  },
                ),
              ],
            ),
            LenraFlex(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'This is a very long text that has absolutely no utility apart to test the utility of a very long text'),
                LenraToggle(
                  value: toggleValue2,
                  onPressed: (newValue) {
                    setState(() {
                      toggleValue2 = newValue;
                    });
                  },
                ),
              ],
            ),
            const LenraFlex(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Toggle disabled'),
                LenraToggle(
                  value: false,
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
