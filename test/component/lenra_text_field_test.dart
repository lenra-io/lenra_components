import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_text_field_style.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  /// The LenraTextField widget defined in this project just passes its properties to the Flutter's TextField widget
  /// except for the style. So we're testing that the style is properly applied to the LenraTextField widget.
  testWidgets('Test LenraTextField', (WidgetTester tester) async {
    var myController = TextEditingController();
    var focusNode = FocusNode(debugLabel: "foo");
    await tester.pumpWidget(createComponentTestWidgets(
      LenraTextField(
        autocorrect: false,
        autofocus: true,
        controller: myController,
        dragStartBehavior: DragStartBehavior.down,
        enabled: true,
        enableInteractiveSelection: false,
        expands: false,
        focusNode: focusNode,
        formatters: null,
        keyboardType: TextInputType.name,
        maxLength: 12,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        minLines: 2,
        maxLines: 3,
        mouseCursor: null,
        obscureText: false,
        readOnly: true,
        showCursor: true,
        textCapitalization: TextCapitalization.characters,
        textDirection: TextDirection.rtl,
        autofillHints: null,
        scrollPhysics: null,
        style: LenraTextFieldStyle(
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
    expect(textField.autofocus, true);
    expect(textField.autofillHints, null);
    expect(textField.autocorrect, false);
    expect(textField.controller, myController);
    expect(textField.dragStartBehavior, DragStartBehavior.down);
    expect(textField.enabled, true);
    expect(textField.enableInteractiveSelection, false);
    expect(textField.expands, false);
    expect(textField.focusNode, focusNode);
    expect(textField.inputFormatters, null);
    expect(textField.keyboardType, TextInputType.name);
    expect(textField.maxLength, 12);
    expect(textField.maxLengthEnforcement, MaxLengthEnforcement.enforced);
    expect(textField.minLines, 2);
    expect(textField.maxLines, 3);
    expect(textField.mouseCursor, null);
    expect(textField.obscureText, false);
    expect(textField.readOnly, true);
    expect(textField.scrollPhysics, null);
    expect(textField.showCursor, true);
    expect(textField.textCapitalization, TextCapitalization.characters);
    expect(textField.textDirection, TextDirection.rtl);
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
