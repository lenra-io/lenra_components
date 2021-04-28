import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';

void main() {
  test('lenra table test parameterized constructor', () {
    LenraTable lenraTable = LenraTable(
      centerChildren: true,
      border: true,
      children: [
        LenraTableRow(
          children: [
            Text("test"),
          ],
        ),
      ],
    );

    expect(lenraTable.centerChildren, true);
    expect(lenraTable.border, true);
  });

  test('lenra table buildChildren function', () {
    List<TableRow> ltr = LenraTable.buildChildren(
      children: [
        LenraTableRow(
          children: [
            Text("test"),
          ],
        ),
      ],
    );

    expect(ltr.first is TableRow, true);
  });
}
