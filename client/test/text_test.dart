// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text.dart';

void main() {
  testWidgets('Create text component', (WidgetTester tester) async {
    String value = 'My text';
    LenraText text = LenraText(value: value);

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: text)));

    expect(find.text(value), findsOneWidget);
    expect(text.value, value);
  });
}
