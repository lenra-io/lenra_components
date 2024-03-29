import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_container.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraContainer test', () {
    LenraContainer container = const LenraContainer(
      child: Text("foo"),
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      constraints: BoxConstraints(),
      decoration: BoxDecoration(color: Colors.red),
    );

    expect(container.alignment, Alignment.center);
    expect(container.padding!.left, 2);
    expect(container.constraints!.minWidth, 0.0);
    expect(container.decoration!.color, Colors.red);
  });

  testWidgets('LenraContainer test padding', (WidgetTester tester) async {
    const double paddingFactor = 16.0;
    const double childHeight = 10.0;
    const double childWidth = 0.0;

    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraContainer(
          child: SizedBox(
            height: childHeight,
            width: childWidth,
          ),
          padding: EdgeInsets.all(paddingFactor),
        ),
      ),
    );

    Size expectedSize = const Size(childWidth + paddingFactor * 2, childHeight + paddingFactor * 2);
    expect(tester.getSize(find.byType(LenraContainer)), expectedSize);
  });

  testWidgets('LenraContainer test constraints', (WidgetTester tester) async {
    const double childHeight = 10.0;
    const double childWidth = 10.0;

    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraContainer(
          child: SizedBox(
            height: childHeight,
            width: childWidth,
          ),
          constraints: BoxConstraints.expand(),
        ),
      ),
    );

    expect(tester.getSize(find.byType(LenraContainer)), const Size(800, 600));
  });

  testWidgets('LenraContainer test decoration', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        LenraContainer(
          child: const SizedBox(),
          border: Border.all(width: 2.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
        ),
      ),
    );

    BoxDecoration decoration = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
    expect(decoration.color, Colors.blue);
    expect(decoration.border!.bottom.width, 2.0);
  });

  testWidgets('LenraContainer test border', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        const LenraContainer(
          child: SizedBox(),
        ),
      ),
    );

    var containerSize = tester.getSize(find.byType(LenraContainer));

    await tester.pumpWidget(
      createComponentTestWidgets(
        LenraContainer(
          child: const SizedBox(),
          border: Border.all(width: 1.0),
        ),
      ),
    );

    var containerWithBorderSize = tester.getSize(find.byType(LenraContainer));

    expect(containerSize.height + 2, containerWithBorderSize.height);
  });
}
