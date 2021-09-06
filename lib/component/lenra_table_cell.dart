import 'package:flutter/material.dart';

/// Lenra implementation of Flutter's [TableCell] widget.
class LenraTableCell extends TableCell {
  final bool verticalCenter;

  const LenraTableCell({
    Key? key,
    Widget child = const SizedBox.shrink(),
    this.verticalCenter = false,
  }) : super(
          key: key,
          child: child,
        );
}
