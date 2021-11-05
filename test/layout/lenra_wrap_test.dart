import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('lenra wrap test parameterized constructor', () {
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

  testWidgets('Test LenraWrap positioning', (WidgetTester tester) async {
    await tester.pumpWidget(createBaseTestWidgets(
      const LenraWrap(
        spacing: 100,
        runSpacing: 2,
        children: [
          Text("foo"),
          Text("bar"),
        ],
      ),
    ));
    await tester.pump();
    expect(tester.getTopLeft(find.text("foo")), const Offset(0, 0));
    expect(tester.getTopLeft(find.text("bar")), const Offset(0, 30));
  });
}
