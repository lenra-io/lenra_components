import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? description;
  final String? errorMessage;
  final bool obscure;
  final bool disabled;
  final bool inRow;
  final bool error;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onSuffixPressed;
  final LenraComponentSize size;
  final double width;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;

  const LenraTextField({
    Key? key,
    this.label,
    this.hintText,
    this.description,
    this.errorMessage,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.error = false,
    this.onChanged,
    this.onSubmitted,
    this.onSuffixPressed,
    this.size = LenraComponentSize.medium,
    this.width = double.infinity,
    this.minLines,
    this.maxLines = 1,
    this.focusNode,
    this.controller,
    this.autofillHints = const <String>[],
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LenraTheme.of(context);
    final LenraTextFieldThemeData lenraTextFieldThemeData = theme.lenraTextFieldThemeData;

    Text? labelWidget = (label == null || label!.isEmpty)
        ? null
        : Text(
            label!,
            style: lenraTextFieldThemeData.getLabelStyle(),
            textAlign: TextAlign.left,
          );
    Widget textField = buildTextField(
      context,
      lenraTextFieldThemeData,
    );

    List<Widget> colChildren = [];

    if (inRow && labelWidget != null) {
      colChildren.add(LenraFlex(
        spacing: 2,
        children: [
          labelWidget,
          Expanded(child: textField),
        ],
      ));
    } else {
      if (labelWidget != null) colChildren.add(labelWidget);
      colChildren.add(textField);
    }
    if (description != null && description!.isNotEmpty && !error) {
      colChildren.add(Text(
        description!,
        style: lenraTextFieldThemeData.getDescriptionStyle(),
        textAlign: TextAlign.left,
      ));
    }
    if (colChildren.length > 1) {
      textField = LenraFlex(
        direction: Axis.vertical,
        spacing: 0.5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: colChildren,
      );
    }
    return SizedBox(
      width: width > 0 ? width : double.infinity,
      child: textField,
    );
  }

  Widget buildTextField(BuildContext context, LenraTextFieldThemeData lenraTextFieldThemeData) {
    return TextField(
      enabled: !disabled,
      obscureText: obscure,
      style: lenraTextFieldThemeData.getLabelStyle(),
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      focusNode: focusNode,
      decoration: lenraTextFieldThemeData.getInputdecoration(
          size, disabled, hintText, error, obscure, onSuffixPressed, errorMessage),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      autofillHints: autofillHints,
    );
  }
}
