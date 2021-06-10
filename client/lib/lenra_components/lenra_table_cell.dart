import 'package:flutter/material.dart';

/// Lenra implementation of Flutter's [TableCell] widget.
class LenraTableCell extends TableCell {
  final bool verticalCenter;

  LenraTableCell({child = const SizedBox.shrink(), this.verticalCenter = false})
      : super(
          child: child,
        );
}
