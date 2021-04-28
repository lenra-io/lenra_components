import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_checkbox.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio_container.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_radio_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

class LenraComponentsShowcase extends StatelessWidget {
  static const routeName = "/showcase";

  final LenraRadioContainer radioContainer = LenraRadioContainer(
    children: [
      LenraRadio(
        value: 1,
      ),
      LenraRadio(
        value: 2,
        text: "Radio n2",
      ),
      LenraRadio(
        value: 2,
        text: "Source Sans Pro",
        fontStyle: "Source Sans Pro",
      ),
      LenraRadio(
        value: 4,
        lenraRadioThemeData: LenraRadioThemeData(colorTheme: LenraColorThemeData(primaryBackgroundColor: Colors.red)),
      ),
      LenraRadio(
        value: 4,
        text: "colored text",
        lenraRadioThemeData: LenraRadioThemeData(
            colorTheme: LenraColorThemeData(primaryBackgroundColor: Colors.red, secondaryForegroundColor: Colors.red)),
      ),
      LenraRadio(
        value: 4,
        text: "disabled colored",
        disabled: true,
        lenraRadioThemeData: LenraRadioThemeData(
            colorTheme: LenraColorThemeData(
                primaryBackgroundDisabledColor: Colors.red[100], secondaryForegroundDisabledColor: Colors.red[100])),
      ),
      LenraRadio(
        value: 2,
        disabled: true,
      ),
      LenraRadio(
        value: 5,
        text: "radio n5",
        disabled: true,
      ),
    ],
  );

  Column buildButton(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(children: [
            new Row(
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
            ),
            new Row(
              children: [
                radioContainer,
                TextButton(
                  onPressed: () => {print(radioContainer.key.currentState.getValue())},
                  child: Row(
                    children: [
                      Text("show"),
                    ],
                  ),
                )
              ],
            ),
            new Row(
              children: [
                LenraCheckbox(
                  value: true,
                  onChanged: (value) => false,
                  text: "text",
                ),
                LenraCheckbox(
                  value: false,
                  onChanged: (value) => false,
                  text: "textstyle",
                  lenraCheckboxThemeData: LenraCheckboxThemeData(
                    lenraTextThemeData: LenraTextThemeData(
                      bodyText: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                LenraCheckbox(
                  value: true,
                  disabled: true,
                  text: "disabled",
                ),
                LenraCheckbox(
                  value: true,
                  disabled: true,
                ),
                LenraCheckbox(
                  value: false,
                  text: "onChanged",
                  onChanged: (value) => print(value),
                ),
                LenraCheckbox(
                  value: null,
                  tristate: true,
                  text: "tristate",
                  onChanged: (value) => print(value),
                ),
              ],
            ),
          ]),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: LenraTable(
            border: true,
            centerChildren: true,
            children: [
              LenraTableRow(
                children: [
                  Text("Row1Cell1"),
                  Text("Row1Cell2"),
                  Icon(Icons.keyboard_arrow_down),
                  LenraButton(
                    text: "Row1",
                    onPressed: () => false,
                  ),
                  Text("Alone"),
                ],
              ),
              LenraTableRow(
                children: [
                  Text("Row2Cell1"),
                  Text("Row2Cell2"),
                  Icon(Icons.keyboard_arrow_up),
                  LenraButton(
                    text: "Row2",
                    onPressed: () => false,
                  ),
                  null,
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
