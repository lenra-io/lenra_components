import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';

class LenraTextFormField extends FormField<String> {
  final String label;
  final String hintText;
  final String description;
  final String errorMessage;
  final bool obscure;
  final bool disabled;
  final bool inRow;
  final Function onEditingComplete;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final LenraTextFieldSize size;
  final double width;
  final FocusNode focusNode;
  final TextEditingController controller;

  LenraTextFormField({
    Key key,
    String initialValue = "",
    validator,
    this.label,
    this.hintText,
    this.description,
    this.errorMessage,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.size = LenraTextFieldSize.Medium,
    this.width,
    this.focusNode,
    this.controller,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState field) {
            return LenraTextField(
              label: label,
              hintText: hintText,
              description: description,
              errorMessage: field.errorText,
              obscure: obscure,
              disabled: disabled,
              inRow: inRow,
              error: field.hasError,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              onChanged: field.didChange,
              size: size,
              width: width,
              focusNode: focusNode,
              controller: controller,
            );
          },
        );

  FormFieldState<String> createState() => _LenraTextFormField();
}

class _LenraTextFormField extends FormFieldState<String> {
  @override
  LenraTextFormField get widget => super.widget;

  @override
  void didChange(String value) {
    super.didChange(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}
