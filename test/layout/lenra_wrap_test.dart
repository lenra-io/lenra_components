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
          children: [
            Text("foo"),
            Text("bar"),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus in sapien id lacinia. Donec vitae erat a metus tristique laoreet at vitae libero. Vivamus non metus elementum, ornare nisi vel, posuere justo. Sed vel odio in nisi eleifend vehicula. Sed dictum mi nec turpis vulputate malesuada. Morbi iaculis faucibus diam nec tempor. Fusce eu molestie urna. Etiam dapibus enim non metus ultrices, ut mattis orci aliquam. Proin iaculis justo nec pulvinar maximus. Cras justo quam, tempor sit amet vestibulum vitae, suscipit a sem. Nunc facilisis, nibh a condimentum viverra, arcu est auctor neque, iaculis pellentesque tellus tellus id metus. Aliquam id elit lectus. Vivamus imperdiet ligula feugiat, fermentum nibh maximus, finibus neque. Aenean magna nisi, porttitor et scelerisque ornare, gravida quis metus.",
            ),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(tester.getSize(find.text("foo")), tester.getSize(find.text("bar")));
    var largeBox = tester.getSize(find.text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus in sapien id lacinia. Donec vitae erat a metus tristique laoreet at vitae libero. Vivamus non metus elementum, ornare nisi vel, posuere justo. Sed vel odio in nisi eleifend vehicula. Sed dictum mi nec turpis vulputate malesuada. Morbi iaculis faucibus diam nec tempor. Fusce eu molestie urna. Etiam dapibus enim non metus ultrices, ut mattis orci aliquam. Proin iaculis justo nec pulvinar maximus. Cras justo quam, tempor sit amet vestibulum vitae, suscipit a sem. Nunc facilisis, nibh a condimentum viverra, arcu est auctor neque, iaculis pellentesque tellus tellus id metus. Aliquam id elit lectus. Vivamus imperdiet ligula feugiat, fermentum nibh maximus, finibus neque. Aenean magna nisi, porttitor et scelerisque ornare, gravida quis metus.",
    ));
    var smallBox = tester.getSize(find.text("foo"));
    expect(largeBox == smallBox, false);
  });

  testWidgets('Test LenraWrap positioning', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraWrap(
        spacing: 20,
        children: [
          Text("foo"),
          Text("bar"),
          Text("test"),
          Text("lorem"),
          Text("ipsum"),
          Text("dolor"),
          Text("sit"),
          Text("amet"),
        ],
      ),
    ));
    await tester.pump();
    expect(tester.getTopLeft(find.text("foo")), const Offset(41, 286));
    expect(tester.getTopLeft(find.text("ipsum")), const Offset(41, 300));
  });
}
