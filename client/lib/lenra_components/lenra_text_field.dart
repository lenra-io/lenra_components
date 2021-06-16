import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

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
  final FocusNode? focusNode;
  final TextEditingController? controller;

  LenraTextField({
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
    this.size = LenraComponentSize.Medium,
    this.width = double.infinity,
    this.focusNode,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LenraTheme.of(context);
    final LenraTextFieldThemeData lenraTextFieldThemeData = theme.lenraTextFieldThemeData;

    Text? labelWidget = (this.label == null || this.label!.isEmpty)
        ? null
        : Text(
            this.label!,
            style: lenraTextFieldThemeData.getLabelStyle(),
            textAlign: TextAlign.left,
          );
    Widget textField = this.buildTextField(
      context,
      lenraTextFieldThemeData,
    );

    List<Widget> colChildren = [];

    if (inRow && labelWidget != null) {
      colChildren.add(LenraRow(
        separationFactor: 2,
        children: [
          labelWidget,
          Expanded(child: textField),
        ],
      ));
    } else {
      if (labelWidget != null) colChildren.add(labelWidget);
      colChildren.add(textField);
    }
    if (this.description != null && this.description!.isNotEmpty && !this.error) {
      colChildren.add(Text(
        this.description!,
        style: lenraTextFieldThemeData.getDescriptionStyle(),
        textAlign: TextAlign.left,
      ));
    }
    if (colChildren.length > 1) {
      textField = LenraColumn(
        separationFactor: 0.5,
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
      enabled: !this.disabled,
      obscureText: this.obscure,
      style: lenraTextFieldThemeData.getLabelStyle(),
      strutStyle: StrutStyle(
        leading: 0.15,
      ),
      controller: controller,
      focusNode: focusNode,
      decoration: lenraTextFieldThemeData.getInputdecoration(
          size, disabled, hintText, error, obscure, onSuffixPressed, errorMessage),
      onSubmitted: this.onSubmitted,
      onChanged: this.onChanged,
    );
  }
}
