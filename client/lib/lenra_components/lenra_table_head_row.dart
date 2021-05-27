import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

/// Lenra implementation of Flutter's [TableRow] widget.
class LenraTableHeadRow {
  final List<Widget> children;

  LenraTableHeadRow({
    this.children,
  });

  TableRow toTableHeadRow({
    LenraTableThemeData lenraTableThemeData,
    bool center = false,
  }) {
    List<Widget> res = children;
    // Wrap in Center widget if `center` is true
    // if (center) {
    //   for (var i = 0; i < this.children.length; i++) {
    //     res[i] = Center(
    //       child: this.children[i],
    //     );
    //   }
    // }

    // Wrap in LenraTableCell
    for (var i = 0; i < this.children.length; i++) {
      res[i] = LenraTableCell(
          verticalCenter: center,
          child: Padding(
            padding: lenraTableThemeData.padding.resolve(LenraComponentSize.Small),
            child: res[i],
          ));
    }

    return TableRow(
      children: res,
    );
  }
}
