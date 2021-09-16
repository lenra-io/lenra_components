import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';

class LenraButtonPage extends StatefulWidget {
  const LenraButtonPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LenraButtonPageState();
  }
}

class _LenraButtonPageState extends State<LenraButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1,
        child: LenraFlex(
          direction: Axis.horizontal,
          children: [
            LenraButton(text: "Basic", onPressed: () {}),
            LenraButton(
              text: "Disabled",
              disabled: true,
              onPressed: () {},
            ),
            LenraButton(
              text: "Large Secondary",
              size: LenraComponentSize.large,
              type: LenraComponentType.secondary,
              onPressed: () {},
            ),
            LenraButton(
              text: "Small Tertiary",
              size: LenraComponentSize.small,
              type: LenraComponentType.tertiary,
              onPressed: () {},
            ),
            LenraButton(
              text: "Left Icon",
              leftIcon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
            LenraButton(
              text: "Right Icon",
              rightIcon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
            LenraButton(
              text: "Right & Left Icon",
              leftIcon: const Icon(Icons.airplanemode_active),
              rightIcon: const Icon(Icons.airplanemode_active),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
