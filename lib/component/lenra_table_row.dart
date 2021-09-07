import 'package:flutter/material.dart';
import 'lenra_table_cell.dart';
import 'package:lenra_components/theme/lenra_table_theme_data.dart';

/// Lenra implementation of Flutter's [TableRow] widget.
class LenraTableRow extends TableRow {
  final bool header;

  const LenraTableRow({
    required List<Widget> children,
    this.header = false,
  }) : super(children: children);

  TableRow toTableRow({
    required EdgeInsetsGeometry padding,
    required LenraTableThemeData theme,
  }) {
    List<Widget> res = List.from(children!);

    // Wrap in LenraTableCell
    for (var i = 0; i < children!.length; i++) {
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
