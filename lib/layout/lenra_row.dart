import 'package:flutter/cupertino.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class LenraRow extends LenraFlex {
  LenraRow({
    Key? key,
    double separationFactor = 1,
    bool fillParent: false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<Widget> children,
    bool scroll = false,
  }) : super(
          key: key,
          direction: Axis.horizontal,
          separationFactor: separationFactor,
          fillParent: fillParent,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
          scroll: scroll,
        );
}
