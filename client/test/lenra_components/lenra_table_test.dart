import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

import '../page/lenra_page_test_help.dart';

void main() {
  test('lenra table test parameterized constructor', () {
    LenraTable lenraTable = LenraTable(
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

    expect(lenraTable.border, true);
    expect(lenraTable.size, LenraComponentSize.Large);
  });

  test('lenra table buildChildren function', () {
    List<TableRow> ltr = LenraTable.buildChildren(
      padding: EdgeInsets.symmetric(vertical: 1 * 8.0, horizontal: 2 * 8.0),
      lenraTableThemeData: LenraTableThemeData(lenraTheme: LenraThemeData()),
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

  testWidgets('Test LenraTable Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTable(
        size: LenraComponentSize.Small,
        children: [
          LenraTableRow(children: [
            Text("test"),
          ])
        ],
      ),
    ));
    /* height 22/24 because of border ?*/
    expect(tester.getSize(find.byType(LenraTableCell)).height, equals(22.0));
  });
  testWidgets('Test LenraTable Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTable(
        size: LenraComponentSize.Medium,
        children: [
          LenraTableRow(children: [
            Text("test"),
          ])
        ],
      ),
    ));

    expect(tester.getSize(find.byType(LenraTableCell)).height, equals(30.0));
  });

  testWidgets('Test LenraTable Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTable(
        size: LenraComponentSize.Large,
        border: true,
        children: [
          LenraTableRow(children: [
            Text("test"),
          ])
        ],
      ),
    ));

    expect(tester.getSize(find.byType(LenraTableCell)).height, equals(38.0));
  });
}
