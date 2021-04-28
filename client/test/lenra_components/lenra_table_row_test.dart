import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';

void main() {
  test('lenra table row test parameterized constructor and toTableRow function', () {
    LenraTableRow lenraTableRow = LenraTableRow(
      children: [
        Text("test"),
      ],
    );

    expect(lenraTableRow.toTableRow() is TableRow, true);
    expect(lenraTableRow.toTableRow().children.first is LenraTableCell, true);
  });
}
