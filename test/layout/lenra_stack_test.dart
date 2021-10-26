import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_stack.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('lenra stack test parameterized constructor', () {
    LenraStack stack = const LenraStack(
      children: [
        Text("foo"),
        Text("bar"),
      ],
    );

    expect(stack.children.length, 2);
    expect(stack.alignment, AlignmentDirectional.topStart);
    expect(stack.fit, StackFit.loose);
  });

  testWidgets('Test LenraStack children', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraStack(
          children: [
            Text("foo"),
            Text("bar"),
          ],
        ),
      ),
    );

    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);

    // Both texts should overlap which means that their topLeft position should be the same.
    expect(tester.getTopLeft(find.text("foo")), tester.getTopLeft(find.text("bar")));
  });

  testWidgets('Test LenraStack alignment', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        const SizedBox.expand(
          child: LenraStack(
            children: [
              Text("foo"),
              Text("bar"),
            ],
            alignment: Alignment.topRight,
          ),
        ),
      ),
    );

    expect(tester.getTopRight(find.text("foo")), const Offset(800, 0));
    expect(tester.getTopRight(find.text("bar")), const Offset(800, 0));

    await tester.pumpWidget(
      createComponentTestWidgets(
        const SizedBox.expand(
          child: LenraStack(
            children: [
              Text("foo"),
              Text("bar"),
            ],
            alignment: Alignment.bottomRight,
          ),
        ),
      ),
    );

    expect(tester.getBottomRight(find.text("foo")), const Offset(800, 600));
    expect(tester.getBottomRight(find.text("bar")), const Offset(800, 600));
  });

  testWidgets('Test LenraStack fit', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraStack(
          children: [
            Text("foo"),
            Text("bar"),
          ],
          fit: StackFit.expand,
        ),
      ),
    );

    expect(tester.getSize(find.text("foo")), const Size(800, 600));
    expect(tester.getSize(find.text("bar")), const Size(800, 600));
  });
}
