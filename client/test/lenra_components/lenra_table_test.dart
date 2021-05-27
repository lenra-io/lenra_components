import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

void main() {
  test('lenra table test parameterized constructor', () {
    LenraTable lenraTable = LenraTable(
      centerChildren: true,
      border: true,
      size: LenraComponentSize.Large,
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
    expect(lenraTable.size, LenraComponentSize.Large);
  });

  test('lenra table buildChildren function', () {
    List<TableRow> ltr = LenraTable.buildChildren(
      padding: EdgeInsets.symmetric(vertical: 1 * 8.0, horizontal: 2 * 8.0),
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
