import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('Test LenraCheckbox value', (WidgetTester tester) async {
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
}
