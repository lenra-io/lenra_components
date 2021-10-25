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
    expect(stack.textDirection, null);
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
}
