import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('lenra text theme data test merge', () {
    final LenraTextThemeData lenraTextThemeDataDefault = LenraTextThemeData();

    final LenraTextThemeData merged = lenraTextThemeDataDefault.copyWith(
        bodyText: const TextStyle(
      color: Colors.red,
      fontFamily: "Source Sans Pro",
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ));

    expect(merged.bodyText.fontFamily, "Source Sans Pro");
    expect(merged.bodyText.fontSize, 14.0);
    expect(merged.bodyText.fontWeight, FontWeight.w400);
    expect(merged.bodyText.color, Colors.red);
  });
  testWidgets('LenraText check size', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        LenraTheme(
          themeData: LenraThemeData(),
          child: const LenraText(text: "foo"),
        ),
      ),
    );

    expect(tester.getSize(find.byType(Text)).height, equals(20.0));
  });
}
