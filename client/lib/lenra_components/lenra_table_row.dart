import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';

/// Lenra implementation of Flutter's [TableRow] widget.
class LenraTableRow extends TableRow {
  final List<Widget> children;
  final bool header;

  LenraTableRow({
    this.children,
    this.header = false,
  });

  TableRow toTableRow({
    EdgeInsetsGeometry padding,
    LenraTableThemeData theme,
  }) {
    List<Widget> res = children;

    // Wrap in LenraTableCell
    for (var i = 0; i < this.children.length; i++) {
      res[i] = LenraTableCell(
        child: Padding(
          padding: padding,
          child: res[i],
        ),
      );
    }

    return TableRow(
      children: res,
      decoration: theme.getBoxDecoration(header),
    );
  }
}
