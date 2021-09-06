import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class LenraFlexExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      children: this.buildColumns(),
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scroll: false,
      fillParent: false,
      spacing: 1,
    );
  }

  List<Widget> buildColumns() {
    return [
      LenraFlex(
        children: buildChildren([Colors.red, Colors.purple, Colors.red]),
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 1,
      ),
      Flexible(
          child: LenraFlex(
        children: buildChildren([Colors.purple, Colors.blue, Colors.purple]),
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 1,
      )),
      LenraFlex(
        children: buildChildren([Colors.red, Colors.purple, Colors.red]),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        direction: Axis.horizontal,
        spacing: 1,
      ),
    ];
  }

  List<Widget> buildChildren(List<Color> colors) {
    return [
      Container(color: colors[0], width: 100, height: 100),
      Flexible(child: Container(color: colors[1], width: 100, height: 100), fit: FlexFit.tight),
      Container(color: colors[2], width: 100, height: 100),
    ];
  }
}
