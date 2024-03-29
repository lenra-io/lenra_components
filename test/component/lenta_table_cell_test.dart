import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_table_cell.dart';

void main() {
  test('lenra table row test parameterized constructor and toTableRow function', () {
    LenraTableCell lenraTableCell = const LenraTableCell(
      child: Text("test"),
    );

    expect(lenraTableCell.child is Text, true);

    LenraTableCell emptyLenraTableCell = const LenraTableCell();
    TableCell emptyTableCell = emptyLenraTableCell;
    expect(emptyTableCell.child is SizedBox, true);
  });
}
