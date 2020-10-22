// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text.dart';

void main() {
  testWidgets('Create text component', (WidgetTester tester) async {
    String value = 'My textfield';
    LenraComponent textfield;

    await tester.pumpWidget(MaterialApp(
      builder: (context, child) {
        textfield = LenraComponent.create({'type': 'text', 'value': value});
        return Scaffold(
          body: textfield,
        );
      },
    ));

    expect(find.text(value), findsOneWidget,
        reason: 'Can\'t find the LenraText widget');
    expect(textfield.properties['value'], value,
        reason: 'LenraText value was not expected value.');
  });
}
