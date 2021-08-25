import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_column.dart';
import 'package:lenra_components/lenra_components.dart';

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
        LenraColumn(
          children: [
            Text("test"),
          ],
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dy, equals(0.0));
  });

  testWidgets('LenraColumn test main centered position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraColumn(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("test"),
          ],
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dy, equals(293.0));
    expect(tester.getTopLeft(find.byType(LenraColumn)).dy, equals(0.0));
  });

  testWidgets('LenraColumn test main spaceBetween position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraColumn(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("test"),
            TextButton(onPressed: () {}, child: Container()),
          ],
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dy, equals(0.0));
    expect(tester.getTopLeft(find.byType(TextButton)).dy, equals(600 - tester.getSize(find.byType(TextButton)).height));
    expect(tester.getTopLeft(find.byType(LenraColumn)).dy, equals(0.0));
  });

  testWidgets('LenraColumn test spacing position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraColumn(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              key: Key("A"),
              height: 30,
            ),
            Container(
              key: Key("B"),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(SizedBox)).height, equals(LenraThemeData().baseSize * 10));
    expect(tester.getTopLeft(find.byKey(Key("A"))).dy, equals(0.0));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dy, equals(30 + LenraThemeData().baseSize * 10));
  });

  testWidgets('LenraColumn test main SpaceEvenly position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraColumn(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Container(
              key: Key("A"),
              height: 30,
            ),
            Container(
              key: Key("B"),
              height: 40,
            ),
            Container(
              key: Key("C"),
              height: 50,
            )
          ],
        ),
      ),
    );
    double x = (600 - 120) / 4;

    expect(tester.getTopLeft(find.byKey(Key("A"))).dy, equals(x));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dy, equals(2 * x + 30));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dy, equals(3 * x + 30 + 40));
  });

  testWidgets('LenraRow test main SpaceAround position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraColumn(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 10,
          children: [
            Container(
              key: Key("A"),
              height: 30,
            ),
            Container(
              key: Key("B"),
              height: 40,
            ),
            Container(
              key: Key("C"),
              height: 50,
            )
          ],
        ),
      ),
    );
    //Screen Size minus compinent size (30+40+50) divided by SpaceAround spacing number
    double x = (600 - 120) / 6;

    //Size cast to int to avoid rounded decimal
    expect(tester.getTopLeft(find.byKey(Key("A"))).dy.toInt(), equals(x.toInt()));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dy.toInt(), equals((3 * x + 30).toInt()));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dy.toInt(), equals((5 * x + 30 + 40).toInt()));
  });
}
