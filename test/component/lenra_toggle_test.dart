import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/theme/lenra_toggle_syle.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('LenraToggle should call onPressed when clicked.', (WidgetTester tester) async {
    var value = false;

    await tester.pumpWidget(
      createComponentTestWidgets(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return LenraToggle(
            key: const Key('toggle'),
            value: value,
            onPressed: (newValue) {
              setState(() {
                value = newValue;
              });
            },
          );
        }),
      ),
    );

    expect(value, false);
    await tester.tap(find.byKey(const Key('toggle')));
    await tester.pump();
    expect(value, true);
  });

  testWidgets('LenraToggle style is properly passed to Flutter\'s Toggle.', (WidgetTester tester) async {
    await tester.pumpWidget(
      createComponentTestWidgets(
        LenraToggle(
          key: const Key('toggle'),
          value: true,
          onPressed: (v) {},
          style: const LenraToggleStyle(
            inactiveThumbColor: Colors.red,
            activeTrackColor: Colors.red,
            hoverColor: Colors.red,
            focusColor: Colors.red,
          ),
        ),
      ),
    );

    Switch toggle = tester.widget(find.byType(Switch));
    expect(toggle.inactiveThumbColor, Colors.red);
    expect(toggle.activeTrackColor, Colors.red);
    expect(toggle.hoverColor, Colors.red);
    expect(toggle.focusColor, Colors.red);
  });
}
