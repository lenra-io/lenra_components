import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_components.dart';

import '../utils/lenra_page_test_help.dart';

//Screen size 800x600

Widget createIn100x100Container(Widget child) {
  return createBaseTestWidgets(
    SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          child: child,
        ),
      ),
    ),
  );
}

List<Widget> createTwo10x10Container() {
  return [
    const SizedBox(
      key: Key("A"),
      width: width,
      height: height,
    ),
    const SizedBox(
      key: Key("B"),
      width: width,
      height: height,
    )
  ];
}

List<Axis> directions = [
  Axis.horizontal,
  Axis.vertical,
];
List<MainAxisAlignment> mainAxisAlignments = [
  MainAxisAlignment.start,
  MainAxisAlignment.center,
  MainAxisAlignment.end,
  MainAxisAlignment.spaceAround,
  MainAxisAlignment.spaceBetween,
  MainAxisAlignment.spaceEvenly,
];
List<CrossAxisAlignment> crossAxisAlignments = [
  CrossAxisAlignment.start,
  CrossAxisAlignment.center,
  CrossAxisAlignment.end,
];
List<bool> fillParents = [true, false];
List<double> spacings = [0, 1, 2];

const double containerWidth = 100;
const double containerHeight = 100;
const double width = 10;
const double height = 10;

void testFor({
  required MainAxisAlignment mainAxisAlignment,
  required CrossAxisAlignment crossAxisAlignment,
  required bool fillParent,
  required double spacing,
  required Axis direction,
  required Offset aTLOffset,
  required Offset bTLOffset,
  required Offset lFBROffset,
}) {
  testWidgets(
      'LenraFlex ${direction.toString()} ${mainAxisAlignment.toString()} ${crossAxisAlignment.toString()} fillParent($fillParent) spacing($spacing)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createIn100x100Container(
        LenraFlex(
          direction: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: spacing,
          fillParent: fillParent,
          children: createTwo10x10Container(),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byKey(const Key("A"))), equals(aTLOffset));
    expect(tester.getTopLeft(find.byKey(const Key("B"))), equals(bTLOffset));

    expect(tester.getTopLeft(find.byType(LenraFlex)), equals(const Offset(0, 0)));
    expect(tester.getBottomRight(find.byType(LenraFlex)), equals(lFBROffset));
  });
}

void main() {
  test('LenraFlex test', () {
    LenraFlex component = const LenraFlex(
      children: [],
    );
    expect(component is LenraFlex, true);
  });

  testFor(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    fillParent: true,
    spacing: 0,
    direction: Axis.horizontal,
    aTLOffset: const Offset(containerWidth / 2 - width, 0),
    bTLOffset: const Offset(containerWidth / 2, 0),
    lFBROffset: const Offset(100, 10),
  );

  testFor(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    fillParent: false,
    spacing: 1,
    direction: Axis.horizontal,
    aTLOffset: const Offset(0, 0),
    bTLOffset: const Offset(width + 8, 0),
    lFBROffset: const Offset(width * 2 + 8, height),
  );

  testWidgets('Padding is properly wrapping Flex', (WidgetTester tester) async {
    await tester.pumpWidget(
      createIn100x100Container(
        LenraFlex(
          padding: const EdgeInsets.all(10.0),
          fillParent: true,
          children: createTwo10x10Container(),
        ),
      ),
    );

    expect(find.byType(Padding), findsOneWidget);
  });

  testWidgets('Flex should have no padding by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      createIn100x100Container(
        LenraFlex(
          fillParent: true,
          children: createTwo10x10Container(),
        ),
      ),
    );

    expect(find.byType(Padding), findsNothing);
  });
  /*testFor(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    fillParent: false,
    spacing: 1,
    direction: Axis.horizontal,
    aTLOffset: Offset(8, 0),
    bTLOffset: Offset(width + 8 * 2, 0),
    lFBROffset: Offset(width * 2 + 8 * 4, height),
  );
  testFor(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    fillParent: false,
    spacing: 1,
    direction: Axis.horizontal,
    aTLOffset: Offset(8, 0),
    bTLOffset: Offset(width + 8 * 2, 0),
    lFBROffset: Offset(width * 2 + 8 * 4, height),
  );*/

/*
  testWidgets('LenraFlexH MainCenter CrossCenter fillParent', (WidgetTester tester) async {
    await tester.pumpWidget(
      createIn100x100Container(
        LenraRow(
          //direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          fillParent: true,
          children: createTwo10x10Container(),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byKey(Key("A"))), equals(Offset(40, 45)));
    expect(tester.getTopLeft(find.byKey(Key("B"))), equals(Offset(50, 45)));

    expect(tester.getTopLeft(find.byType(LenraRow)), equals(Offset(0, 0)));
    expect(tester.getBottomRight(find.byType(LenraRow)), equals(Offset(100, 100)));
  });

  testWidgets('LenraFlexH MainCenter notFillParent', (WidgetTester tester) async {
    await tester.pumpWidget(
      createIn100x100Container(
        LenraFlex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          fillParent: false,
          children: createTwo10x10Container(),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byKey(Key("A"))), equals(Offset(0, 0)));
    expect(tester.getTopLeft(find.byKey(Key("B"))), equals(Offset(10, 0)));

    expect(tester.getTopLeft(find.byType(LenraRow)), equals(Offset(0, 0)));
    expect(tester.getBottomRight(find.byType(LenraRow)), equals(Offset(20, 20)));
  });

  testWidgets('LenraRow test main spaceBetween position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraRow(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("test"),
            TextButton(onPressed: () {}, child: Container()),
          ],
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(Text)).dx, equals(0.0));
    expect(tester.getTopLeft(find.byType(TextButton)).dx, equals(800 - tester.getSize(find.byType(TextButton)).width));
    expect(tester.getTopLeft(find.byType(LenraRow)).dx, equals(0.0));
  });

  testWidgets('LenraRow test spacing position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraRow(
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
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(SizedBox)).width, equals(LenraThemeData().baseSize * 10));
    expect(tester.getTopLeft(find.byKey(Key("A"))).dx, equals(0.0));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx, equals(30 + LenraThemeData().baseSize * 10));
  });

  testWidgets('LenraRow test main SpaceEvenly position', (WidgetTester tester) async {
    double spacing = 10;
    double width = 30;
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraRow(
          fillParent: false,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: spacing,
          children: [
            Container(
              key: Key("A"),
              width: width,
            ),
            Container(
              key: Key("B"),
              width: width,
            ),
            Container(
              key: Key("C"),
              width: width,
            )
          ],
        ),
      ),
    );
    double space = LenraThemeData().baseSize * 10;
    expect(tester.getTopLeft(find.byKey(Key("A"))).dx, equals(space));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx, equals(space * 2 + width));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dx, equals(space * 3 + width * 2));
  });

  testWidgets('LenraRow test main SpaceAround position', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        LenraRow(
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
    );
    //Screen Size minus compinent size (30+40+50) divided by SpaceAround spacing number
    double x = (800 - 120) / 6;

    //Size cast to int to avoid rounded decimal
    expect(tester.getTopLeft(find.byKey(Key("A"))).dx.toInt(), equals(x.toInt()));
    expect(tester.getTopLeft(find.byKey(Key("B"))).dx.toInt(), equals((3 * x + 30).toInt()));
    expect(tester.getTopLeft(find.byKey(Key("C"))).dx.toInt(), equals((5 * x + 30 + 40).toInt()));
  });*/
}
