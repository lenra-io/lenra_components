import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/component/lenra_radio.dart';
import 'package:lenra_components/theme/lenra_radio_style.dart';

import '../utils/lenra_page_test_help.dart';

void main() {
  test('LenraRadio test', () {
    LenraRadio component = LenraRadio<String>(
      value: "Foo",
      onPressed: (String? value) {},
      groupValue: "Foo",
    );
    expect(component is LenraRadio, true);
  });

  testWidgets('Test Basic LenraRadio', (WidgetTester tester) async {
    final List<String?> log = <String?>[];
    const radioKey = Key("A");

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        key: radioKey,
        value: "Foo",
        onPressed: log.add,
        groupValue: "Bar",
      ),
    ));

    await tester.tap(find.byKey(radioKey));

    expect(log, equals(<String>["Foo"]));
    log.clear();

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        key: radioKey,
        value: "Foo",
        onPressed: log.add,
        groupValue: "Foo",
      ),
    ));

    await tester.tap(find.byKey(radioKey));

    expect(log, isEmpty);
  });

  testWidgets('Test LenraRadio style', (WidgetTester tester) async {
    Color activeColor = Colors.blue;
    Color focusColor = Colors.red;
    Color hoverColor = Colors.green;
    double splashRadius = 12;
    VisualDensity visualDensity = VisualDensity.compact;

    Radio<String> tmp = Radio<String>(
      onChanged: (String? v) {},
      groupValue: "t",
      value: "t",
    );

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        value: "Foo",
        onPressed: (String? v) {},
        groupValue: "Bar",
        style: LenraRadioStyle(
          activeColor: activeColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashRadius: splashRadius,
          visualDensity: visualDensity,
        ),
      ),
    ));

    Radio radio = tester.widget(find.byType(tmp.runtimeType));
    expect(radio.activeColor, activeColor);
    expect(radio.focusColor, focusColor);
    expect(radio.hoverColor, hoverColor);
    expect(radio.splashRadius, splashRadius);
    expect(radio.visualDensity, visualDensity);
  });

  testWidgets('Test LenraRadio toggleable', (WidgetTester tester) async {
    final List<String?> log = <String?>[];
    const radioKey = Key("A");

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        key: radioKey,
        value: "Foo",
        onPressed: log.add,
        groupValue: "Bar",
        toggleable: true,
      ),
    ));

    await tester.tap(find.byKey(radioKey));
    expect(log, equals(<String>["Foo"]));
    log.clear();

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        key: radioKey,
        value: "Foo",
        onPressed: log.add,
        groupValue: "Foo",
        toggleable: true,
      ),
    ));

    await tester.tap(find.byKey(radioKey));
    expect(log, equals(<String?>[null]));
  });

  testWidgets('Test LenraRadio materialTapTargetSize', (WidgetTester tester) async {
    Radio<String> tmp = Radio<String>(
      onChanged: (String? v) {},
      groupValue: "t",
      value: "t",
    );

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        value: "Foo",
        onPressed: (String? v) {},
        groupValue: "Bar",
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    ));

    expect(tester.getSize(find.byType(tmp.runtimeType)), const Size(48, 48));

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        value: "Foo",
        onPressed: (String? v) {},
        groupValue: "Bar",
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ));

    expect(tester.getSize(find.byType(tmp.runtimeType)), const Size(40, 40));
  });

  testWidgets('Test LenraRadio is focusable', (WidgetTester tester) async {
    FocusNode focusNode = FocusNode(debugLabel: 'Radio');

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        value: "Foo",
        onPressed: (String? v) {},
        groupValue: "Bar",
        autofocus: true,
        focusNode: focusNode,
      ),
    ));

    await tester.pumpAndSettle();
    expect(focusNode.hasPrimaryFocus, isTrue);

    await tester.pumpWidget(createComponentTestWidgets(
      LenraRadio<String>(
        value: "Foo",
        onPressed: null,
        groupValue: "Bar",
        autofocus: false,
        focusNode: focusNode,
      ),
    ));

    await tester.pumpAndSettle();
    expect(focusNode.hasPrimaryFocus, isFalse);
  });
}
