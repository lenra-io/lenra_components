import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('lenra table row test parameterized constructor and toTableRow function', () {
    LenraTableRow lenraTableRow = LenraTableRow(
      children: [
        Text("test"),
      ],
    );

    expect(
        lenraTableRow.toTableRow(
          padding: EdgeInsets.symmetric(vertical: 1 * 8.0, horizontal: 2 * 8.0),
          theme: LenraTableThemeData(lenraTheme: LenraThemeData()),
        ) is TableRow,
        true);
    expect(
        lenraTableRow
            .toTableRow(
              padding: EdgeInsets.symmetric(vertical: 1 * 8.0, horizontal: 2 * 8.0),
              theme: LenraTableThemeData(lenraTheme: LenraThemeData()),
            )
            .children!
            .first is LenraTableCell,
        true);
  });
}
