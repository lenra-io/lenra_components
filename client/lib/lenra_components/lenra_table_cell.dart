import 'package:flutter/material.dart';

/// Lenra implementation of Flutter's [TableCell] widget.
class LenraTableCell extends StatelessWidget {
  final Widget child;
  final bool verticalCenter;

  LenraTableCell({this.child, this.verticalCenter = false});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: verticalCenter ? TableCellVerticalAlignment.middle : TableCellVerticalAlignment.top,
      child: this.child ?? SizedBox.shrink(),
    );
  }
}
