import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import 'package:lenra_components/lenra_components.dart';

class LenraStyledContainerTest extends StatelessWidget {
  final List<bool> selectedItems = [false, false];

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      fillParent: true,
      spacing: 2,
      children: [
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraStyledContainer(
              color: Colors.purple,
              child: this.square("Purple"),
            ),
            LenraStyledContainer(
              color: Colors.green,
              child: this.square("Green"),
            ),
            LenraStyledContainer(
              color: Colors.orange,
              child: this.square("Orange"),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraStyledContainer(
              color: Color(0xFFEEEEEE),
              child: this.square("Border 1px"),
              border: Border.all(width: 1),
            ),
            LenraStyledContainer(
              color: Color(0xFFEEEEEE),
              child: this.square("Border color"),
              border: Border.all(width: 3, color: Colors.lightBlue),
            ),
            LenraStyledContainer(
              color: Color(0xFFEEEEEE),
              child: this.square("BorderRadius"),
              border: Border.all(width: 3, color: Colors.lightBlue),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraStyledContainer(
              color: Color(0xFFEEEEEE),
              child: this.square("Shadow"),
              boxShadow: BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(2, 2), blurRadius: 2),
            ),
            LenraStyledContainer(
              color: Color(0xFFEEEEEE),
              child: this.square("Shadow color"),
              boxShadow: BoxShadow(color: Colors.purple.withOpacity(0.4), offset: Offset(3, 3), blurRadius: 2),
            ),
            LenraStyledContainer(
              color: Colors.cyan,
              child: this.square("All in one"),
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(10, 20),
                topLeft: Radius.elliptical(10, 20),
              ),
              boxShadow: BoxShadow(
                color: Colors.black26,
                offset: Offset(5, 2),
                blurRadius: 3,
                spreadRadius: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget square(String text) {
    return Container(height: 100, width: 100, child: Center(child: Text(text)));
  }
}
