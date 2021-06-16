import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_flex.dart';

class LenraRow extends LenraFlex {
  LenraRow({
    Key? key,
    double separationFactor = 1,
    bool fillParent: false,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<Widget> children,
  }) : super(
          key: key,
          direction: Axis.horizontal,
          separationFactor: separationFactor,
          fillParent: fillParent,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}
