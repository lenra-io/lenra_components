import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraWrap parameterized constructor', () {
    LenraWrap wrap = const LenraWrap(
      children: [
        Text("foo"),
        Text("bar"),
        Text("test"),
        Text("lorem"),
        Text("ipsum"),
      ],
    );

    expect(wrap.children.length, 5);
    expect(wrap.direction, Axis.horizontal);
    expect(wrap.crossAxisAlignment, WrapCrossAlignment.start);
    expect(wrap.runAlignment, WrapAlignment.start);
    expect(wrap.alignment, WrapAlignment.start);
    expect(wrap.spacing, 0);
    expect(wrap.runSpacing, 0);
    expect(wrap.verticalDirection, VerticalDirection.down);
    expect(wrap.horizontalDirection, null);
  });

  testWidgets('LenraWrap should properly wrap children', (WidgetTester tester) async {
    await tester.pumpWidget(createBaseTestWidgets(
      const LenraWrap(
        spacing: 100,
        runSpacing: 2,
        children: [
          SizedBox(
            key: Key("sb1"),
            width: 1,
          ),
          SizedBox(key: Key("sb2")),
        ],
      ),
    ));

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb1"))), const Offset(0, 0));
    expect(tester.getTopLeft(find.byKey(const Key("sb2"))), const Offset(0, 16));
  });

  testWidgets('LenraWrap direction should work', (WidgetTester tester) async {
    await tester.pumpWidget(createBaseTestWidgets(
      const LenraWrap(
        spacing: 75,
        runSpacing: 2,
        direction: Axis.vertical,
        children: [
          SizedBox(
            key: Key("sb1"),
            height: 1,
          ),
          SizedBox(key: Key("sb2")),
        ],
      ),
    ));

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb1"))), const Offset(0, 0));
    expect(tester.getTopLeft(find.byKey(const Key("sb2"))), const Offset(16, 0));
  });

  testWidgets('LenraWrap crossAxisAlignment should work', (WidgetTester tester) async {
    const double sb1Height = 60;
    const double sb2Height = 30;
    const double sb2TopLeftCenteredY = (sb1Height - sb2Height) / 2;

    await tester.pumpWidget(createBaseTestWidgets(
      const LenraWrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            key: Key("sb1"),
            height: sb1Height,
          ),
          SizedBox(
            key: Key("sb2"),
            height: sb2Height,
          ),
        ],
      ),
    ));

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb2"))), const Offset(0, sb2TopLeftCenteredY));
  });

  testWidgets('LenraWrap alignment should work', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        const SizedBox.expand(
          child: LenraWrap(
            alignment: WrapAlignment.end,
            children: [
              SizedBox(key: Key("sb1")),
            ],
          ),
        ),
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb1"))), const Offset(800, 0));
  });

  testWidgets('LenraWrap runAlignment should work', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        const SizedBox.expand(
          child: LenraWrap(
            runAlignment: WrapAlignment.end,
            children: [
              SizedBox(key: Key("sb1")),
            ],
          ),
        ),
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb1"))), const Offset(0, 600));
  });

  testWidgets('LenraWrap horizontalDirection should work', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        const SizedBox.expand(
          child: LenraWrap(
            horizontalDirection: TextDirection.rtl,
            children: [
              SizedBox(key: Key("sb1")),
            ],
          ),
        ),
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.byKey(const Key("sb1"))), const Offset(800, 0));
  });
}
