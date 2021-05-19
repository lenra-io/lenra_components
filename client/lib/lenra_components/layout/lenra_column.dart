import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_flex.dart';

class LenraColumn extends LenraFlex {
  LenraColumn({
    Key key,
    double separationFactor = 1,
    bool fillParent: false,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    List<Widget> children,
  }) : super(
          key: key,
          direction: Axis.vertical,
          separationFactor: separationFactor,
          fillParent: fillParent,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}
