import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('Test LenraCheckbox value and tristate', (WidgetTester tester) async {
    bool? value = false;

    await tester.pumpWidget(createComponentTestWidgets(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return LenraCheckbox(
            value: value,
            onPressed: (bool? v) {
              setState(() {
                value = v;
              });
            },
          );
        },
      ),
    ));

    expect(value, false);

    await tester.tap(find.byType(LenraCheckbox));
    await tester.pumpAndSettle();
    expect(value, true);

    await tester.tap(find.byType(LenraCheckbox));
    await tester.pumpAndSettle();
    expect(value, false);

    await tester.pumpWidget(createComponentTestWidgets(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return LenraCheckbox(
            value: value,
            tristate: true,
            onPressed: (bool? v) {
              setState(() {
                value = v;
              });
            },
          );
        },
      ),
    ));

    await tester.tap(find.byType(LenraCheckbox));
    await tester.pumpAndSettle();
    expect(value, true);

    await tester.tap(find.byType(LenraCheckbox));
    await tester.pumpAndSettle();
    expect(value, null);

    await tester.tap(find.byType(LenraCheckbox));
    await tester.pumpAndSettle();
    expect(value, false);
  });

  testWidgets('Test LenraCheckbox disabled', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraCheckbox(
        value: true,
        onPressed: null,
      ),
    ));

    /// According to flutter's documentation, when the `onChanged` property is `null` then the `Checkbox` is disabled.
    /// https://api.flutter.dev/flutter/material/Checkbox/onChanged.html
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).onChanged, null);
  });

  testWidgets('Test LenraCheckbox style', (WidgetTester tester) async {
    bool value = false;

    await tester.pumpWidget(createComponentTestWidgets(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return LenraCheckbox(
            value: value,
            onPressed: (bool? v) {
              setState(() {
                value = v!;
              });
            },
            style: LenraCheckboxStyle(
              activeColor: Colors.blue.shade50,
              checkColor: Colors.blue.shade100,
              focusColor: Colors.blue.shade200,
              hoverColor: Colors.blue.shade300,
              splashRadius: 10.0,
              visualDensity: VisualDensity.compact,
              shape: const CircleBorder(),
              side: const BorderSide(width: 10),
            ),
          );
        },
      ),
    ));

    Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.activeColor, Colors.blue.shade50);
    expect(checkbox.checkColor, Colors.blue.shade100);
    expect(checkbox.focusColor, Colors.blue.shade200);
    expect(checkbox.hoverColor, Colors.blue.shade300);
    expect(checkbox.splashRadius, 10.0);
    expect(checkbox.visualDensity, VisualDensity.compact);
    expect(checkbox.shape.runtimeType, CircleBorder);
    expect(checkbox.side!.width, 10);
  });
}
