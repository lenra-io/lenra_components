import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

class LenraComponentsShowcase extends StatelessWidget {
  static const routeName = "/showcase";

  SingleChildScrollView buildButton(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            LenraButton(onPressed: () => false, text: "Test d'un bouton très long"),
            LenraButton(disabled: true, onPressed: () => false, text: "Test"),
            LenraButton(onPressed: () => false, text: "Large", size: LenraButtonSize.Large),
            LenraButton(onPressed: () => false, text: "Small", size: LenraButtonSize.Small),
            LenraButton(onPressed: () => false, text: "Label"),
            LenraButton(
              onPressed: () => false,
              text: "Label",
              leftIcon: Icon(Icons.keyboard_arrow_down),
            ),
            LenraButton(
              onPressed: () => false,
              text: "Label",
              rightIcon: Icon(Icons.keyboard_arrow_down),
            ),
            LenraButton(
              onPressed: () => false,
              text: "Label",
              leftIcon: Icon(Icons.keyboard_arrow_down),
              rightIcon: Icon(Icons.keyboard_arrow_down),
            ),
            LenraButton(onPressed: () => false, text: "Secondary", type: LenraButtonType.Secondary),
            LenraButton(
                onPressed: () => false, text: "SecondaryDisabled", type: LenraButtonType.Secondary, disabled: true),
            LenraButton(onPressed: () => false, text: "Tertiary", type: LenraButtonType.Tertiary),
            LenraButton(
                onPressed: () => false, text: "TertiaryDisabled", type: LenraButtonType.Tertiary, disabled: true),
            LenraButton(
              onPressed: () => false,
              text: "Red Background",
              type: LenraButtonType.Primary,
              lenraButtonThemeData: LenraButtonThemeData(
                colorTheme: LenraColorThemeData(primaryBackgroundColor: Colors.red),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildButton(context),
        ],
      ),
    );
  }
}
