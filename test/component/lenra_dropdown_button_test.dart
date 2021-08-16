import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  LenraMenu basicMenu = LenraMenu(
    items: [
      LenraMenuItem(text: "one", value: 1, onPressed: (value) => {}),
      LenraMenuItem(text: "two", value: 2, onPressed: (value) => {}),
    ],
  );

  LenraDropdownButton basicDropdown = LenraDropdownButton(
    text: "basic",
    menu: basicMenu,
  );

  test('LenraDropdownButton test parameterized constructor', () {
    LenraDropdownButton lenraDropdownButton = LenraDropdownButton(
      disabled: true,
      text: "disabled",
      size: LenraComponentSize.Large,
      type: LenraComponentType.Secondary,
      menu: basicMenu,
    );

    expect(lenraDropdownButton.disabled, true);
    expect(lenraDropdownButton.text, "disabled");
    expect(lenraDropdownButton.size, LenraComponentSize.Large);
    expect(lenraDropdownButton.type, LenraComponentType.Secondary);
    expect(lenraDropdownButton.menu, basicMenu);
    expect(lenraDropdownButton.icon.toString(), Icon(Icons.expand_more_outlined).toString());
  });

  test('LenraDropdownButton test', () {
    expect(basicDropdown is LenraDropdownButton, true);
  });

  testWidgets('LenraDropdownButton should have an Icon', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(basicDropdown));

    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('LenraDropdownButton click should open Menu Overlay', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(basicDropdown));

    expect(find.byType(OverlayEntry), findsNothing);

    await tester.tap(find.byType(LenraDropdownButton));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(find.byType(LenraMenu), findsOneWidget);
  });
}
