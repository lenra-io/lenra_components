import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';

import '../../page/lenra_page_test_help.dart';

void main() {
  test('LenraRow test', () {
    LenraRow component = LenraRow(
      children: [],
    );
    expect(component is LenraRow, true);
  });

  testWidgets('LenraRow test position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              children: [
                Text("test"),
              ],
            ),
          ),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dx, equals(0.0));
  });

  testWidgets('LenraRow test main centered position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              fillParent: true,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("test"),
              ],
            ),
          ),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dx, equals(372.0));
    expect(tester.getTopLeft(find.byType(LenraRow)).dx, equals(0.0));
  });
}
