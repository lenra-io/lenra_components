import 'package:flutter/material.dart';

/// Lenra implementation of Flutter's [TableCell] widget.
class LenraTableCell extends TableCell {
  final bool verticalCenter;

  LenraTableCell({child = const SizedBox.shrink(), this.verticalCenter = false})
      : super(
          verticalAlignment: verticalCenter ? TableCellVerticalAlignment.middle : TableCellVerticalAlignment.top,
          child: child,
        );

  // @override
  // Widget build(BuildContext context) {
  //   return TableCell(
  //     verticalAlignment: verticalCenter ? TableCellVerticalAlignment.middle : TableCellVerticalAlignment.top,
  //     child: this.child ?? SizedBox.shrink(),
  //   );
  // }
}
