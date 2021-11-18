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
    Color activeColor = Colors.blue.shade50;
    Color checkColor = Colors.blue.shade100;
    Color focusColor = Colors.blue.shade200;
    Color hoverColor = Colors.blue.shade300;
    double splashRadius = 10.0;
    VisualDensity visualDensity = VisualDensity.compact;
    const CircleBorder shape = CircleBorder();
    const BorderSide side = BorderSide(width: 10);

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
              activeColor: activeColor,
              checkColor: checkColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              splashRadius: splashRadius,
              visualDensity: visualDensity,
              shape: shape,
              side: side,
            ),
          );
        },
      ),
    ));

    Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.activeColor, activeColor);
    expect(checkbox.checkColor, checkColor);
    expect(checkbox.focusColor, focusColor);
    expect(checkbox.hoverColor, hoverColor);
    expect(checkbox.splashRadius, splashRadius);
    expect(checkbox.visualDensity, visualDensity);
    expect(checkbox.shape.runtimeType, shape.runtimeType);
    expect(checkbox.side!.width, side.width);
  });
}
