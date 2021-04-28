import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';

/// Lenra implementation of Flutter's [TableRow] widget.
class LenraTableRow {
  final List<Widget> children;

  LenraTableRow({this.children});

  TableRow toTableRow({bool center = false}) {
    List<Widget> res = children;

    // Wrap in Center widget if `center` is true
    if (center) {
      for (var i = 0; i < this.children.length; i++) {
        res[i] = Center(
          child: this.children[i],
        );
      }
    }

    // Wrap in LenraTableCell
    for (var i = 0; i < this.children.length; i++) {
      res[i] = LenraTableCell(
        verticalCenter: center,
        child: res[i],
      );
    }

    return TableRow(
      children: res,
    );
  }
}
