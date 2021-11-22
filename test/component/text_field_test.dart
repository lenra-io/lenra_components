import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/text_field.dart';
import 'package:lenra_components/theme/text_field_style.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  /// The TextField widget defined in this project just passes its properties to the Flutter's TextField widget except
  /// for the style. So we're testing that the style is properly applied to the TextField widget.
  testWidgets('Test TextField style', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LTextField(
        style: TextFieldStyle(
          cursorColor: Colors.red,
          cursorHeight: 10,
          cursorRadius: const Radius.circular(3),
          cursorWidth: 10,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardAppearance: Brightness.dark,
          obscuringCharacter: '*',
          scrollPadding: const EdgeInsets.all(10),
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          strutStyle: null,
          textStyle: const TextStyle(
            color: Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    ));

    final TextField textField = tester.widget(find.byType(TextField));
    expect(textField.cursorColor, Colors.red);
    expect(textField.cursorHeight, 10);
    expect(textField.cursorRadius, const Radius.circular(3));
    expect(textField.cursorWidth, 10);
    expect(textField.decoration?.border.runtimeType, OutlineInputBorder);
    expect(textField.keyboardAppearance, Brightness.dark);
    expect(textField.obscuringCharacter, '*');
    expect(textField.scrollPadding, const EdgeInsets.all(10));
    expect(textField.selectionHeightStyle, BoxHeightStyle.max);
    expect(textField.selectionWidthStyle, BoxWidthStyle.max);
    expect(textField.strutStyle, null);
    expect(textField.style?.color, Colors.red);
    expect(textField.style?.fontSize, 10);
    expect(textField.style?.fontWeight, FontWeight.bold);
    expect(textField.textAlign, TextAlign.center);
    expect(textField.textAlignVertical, TextAlignVertical.center);
  });
}
