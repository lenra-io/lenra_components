import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_column.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraColumn test', () {
    LenraColumn component = LenraColumn(
      children: [],
    );
    expect(component is LenraColumn, true);
  });

  testWidgets('LenraColumn test position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraColumn(
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

  testWidgets('LenraColumn test main centered position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraColumn(
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

    expect(tester.getTopLeft(find.byType(Text)).dy, equals(293.0));
    expect(tester.getTopLeft(find.byType(LenraColumn)).dy, equals(0.0));
  });
}
