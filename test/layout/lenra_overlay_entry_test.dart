import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/layout/lenra_overlay_entry.dart';
import '../utils/lenra_page_test_help.dart';

void main() {
  testWidgets('Test OverlayEntry', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      const LenraOverlayEntry(
        child: Text("Foo"),
        showOverlay: true,
      )
    ));

    expect(find.text("Foo"), findsNothing);

    await tester.pump();

    expect(find.text("Foo"), findsOneWidget);
  });
}
