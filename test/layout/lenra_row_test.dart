import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_row.dart';
import 'package:lenra_components/lenra_components.dart';

import '../utils/lenra_page_test_help.dart';

//Screen size 800x600
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

  testWidgets('LenraRow test main centered position',
      (WidgetTester tester) async {
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

  testWidgets('LenraRow test main spaceBetween position',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              fillParent: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("test"),
                TextButton(onPressed: () {}, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dx, equals(0.0));
    expect(tester.getTopLeft(find.byType(TextButton)).dx,
        equals(800 - tester.getSize(find.byType(TextButton)).width));
    expect(tester.getTopLeft(find.byType(LenraRow)).dx, equals(0.0));
  });

  testWidgets('LenraRow test spacing position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              fillParent: true,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                Container(
                  key: Key("A"),
                  width: 30,
                ),
                Container(
                  key: Key("B"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(SizedBox)).width,
        equals(LenraThemeData().baseSize * 10));
    expect(tester.getTopLeft(find.byKey(Key("A"))).dx, equals(0.0));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx,
        equals(30 + LenraThemeData().baseSize * 10));
  });

  testWidgets('LenraRow test main SpaceEvenly position',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              fillParent: true,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: [
                Container(
                  key: Key("A"),
                  width: 30,
                ),
                Container(
                  key: Key("B"),
                  width: 40,
                ),
                Container(
                  key: Key("C"),
                  width: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
    expect(tester.getTopLeft(find.byKey(Key("A"))).dx, equals(170));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx, equals(370));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dx, equals(580));
  });

  testWidgets('LenraRow test main SpaceAround position',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        MaterialApp(
          home: Scaffold(
            body: LenraRow(
              fillParent: true,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 10,
              children: [
                Container(
                  key: Key("A"),
                  width: 30,
                ),
                Container(
                  key: Key("B"),
                  width: 40,
                ),
                Container(
                  key: Key("C"),
                  width: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
    //Screen Size minus compinent size (30+40+50) divided by SpaceAround spacing number
    double x = (800 - 120) / 6;

    //Size cast to int to avoid rounded decimal
    expect(
        tester.getTopLeft(find.byKey(Key("A"))).dx.toInt(), equals(x.toInt()));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx.toInt(),
        equals((3 * x + 30).toInt()));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dx.toInt(),
        equals((5 * x + 30 + 40).toInt()));
  });
}
