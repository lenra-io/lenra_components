import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_components/lenra_components.dart';

class DropdownExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      fillParent: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LenraDropdownButton(
              text: "Top Left",
              child: buildMenu(),
            ),
            LenraDropdownButton(
              text: "Top Right",
              child: buildMenu(),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LenraDropdownButton(
              text: "Custom child",
              child: LenraMenu(
                items: [
                  LenraMenuItem(
                    text: List.filled(100, "Long ").join(),
                    onPressed: () {},
                  ),
                  LenraMenuItem(
                    text: List.filled(10, "Long 2").join(),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            LenraDropdownButton(
              text: "Fullscreen Dropdown (Too many items)",
              child: LenraMenu(
                items: List.filled(60, LenraMenuItem(text: "item", onPressed: () => {})),
              ),
            ),
            LenraDropdownButton(
              text: "Custom child",
              child: Text(
                "custom",
                style: TextStyle(
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LenraDropdownButton(
              text: "Bottom Left",
              child: buildMenu(),
            ),
            LenraDropdownButton(
              text: "Bottom Right",
              child: buildMenu(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMenu() {
    return LenraMenu(
      items: [
        LenraMenuItem(
          text: "First",
          onPressed: () => {},
        ),
        LenraMenuItem(
          text: "Second",
          onPressed: () => {},
        ),
        LenraMenuItem(
          text: "Third",
          onPressed: () => {},
        ),
      ],
    );
  }
}
