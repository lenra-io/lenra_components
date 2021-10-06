import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraText parameterized constructor', () {
    LenraText lenraText = const LenraText("foo", style: LenraTextStyle.headline1);

    expect(lenraText.text, "foo");
    expect(lenraText.style, LenraTextStyle.headline1);
  });

  testWidgets('Basic LenraText', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraText("foo", style: LenraTextStyle.headline1),
    ));

    expect((tester.widget(find.byType(Text)) as Text).style!.fontSize, LenraTextThemeData().headline1.fontSize);
  });
}
