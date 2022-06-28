import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_table.dart';
import 'package:lenra_components/component/lenra_table_cell.dart';
import 'package:lenra_components/component/lenra_table_row.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('lenra table test parameterized constructor', () {
    LenraTable lenraTable = const LenraTable(
      border: true,
      size: LenraComponentSize.large,
      children: [
        LenraTableRow(
          children: [
            Text("test"),
          ],
        ),
      ],
    );

    expect(lenraTable.border, true);
    expect(lenraTable.size, LenraComponentSize.large);
  });

  testWidgets('Test LenraTable Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraTable(
        size: LenraComponentSize.small,
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
      const LenraTable(
        size: LenraComponentSize.medium,
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
      const LenraTable(
        size: LenraComponentSize.large,
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
