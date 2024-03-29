import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraText parameterized constructor', () {
    var style = const TextStyle(
      fontSize: 2,
      fontStyle: FontStyle.italic,
    );
    LenraText lenraText = LenraText(
      text: "foo",
      spellOut: false,
      style: style,
      semanticsLabel: "bar",
      locale: const Locale('fr', 'FR'),
      textAlign: TextAlign.center,
    );

    expect(lenraText.text, "foo");
    expect(lenraText.style, style);
    expect(lenraText.spellOut, false);
    expect(lenraText.semanticsLabel, "bar");
    expect(lenraText.locale, const Locale('fr', 'FR'));
    expect(lenraText.textAlign, TextAlign.center);
  });

  testWidgets('Test LenraText children', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraText(
        text: "Test",
        children: [
          LenraText(
            text: "Foo",
            children: [LenraText(text: "Baz")],
          ),
          LenraText(
            text: "Bar",
          )
        ],
      ),
    ));

    expect(find.text("TestFooBazBar"), findsOneWidget);
  });
}
