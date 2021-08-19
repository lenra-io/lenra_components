import 'package:flutter/cupertino.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class LenraColumn extends LenraFlex {
  LenraColumn({
    Key? key,
    double spacing = 0,
    bool fillParent: false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    bool scroll = false,
    required List<Widget> children,
  }) : super(
          key: key,
          direction: Axis.vertical,
          spacing: spacing,
          fillParent: fillParent,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
          scroll: scroll,
        );
}
