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
    expect(wrap.textDirection, null);
  });

  testWidgets('Test LenraWrap children', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraWrap(
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          children: [
            Text("foo"),
            Text("bar"),
            Text("test"),
            Text("lorem"),
            Text("ipsum"),
          ],
        ),
      ),
    );

    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);
    expect(find.text("test"), findsOneWidget);
    expect(find.text("lorem"), findsOneWidget);
    expect(find.text("ipsum"), findsOneWidget);
  });
}
