import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_status_sticker.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('LenraStatusSticker size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraStatusSticker(
        color: LenraColorThemeData.lenraCustomGreen,
      ),
    ));

    final BuildContext context = tester.element(find.byType(LenraStatusSticker));
    final Size statusSize = tester.getSize(find.byType(LenraStatusSticker));
    final double expectedSize = LenraTheme.of(context).baseSize;

    expect(statusSize.height, expectedSize);
    expect(statusSize.width, expectedSize);
  });

  testWidgets('LenraStatusSticker custom color', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraStatusSticker(
        color: LenraColorThemeData.lenraCustomGreen,
      ),
    ));

    expect((tester.widget(find.byType(LenraStatusSticker)) as LenraStatusSticker).color,
        LenraColorThemeData.lenraCustomGreen);
  });
}
