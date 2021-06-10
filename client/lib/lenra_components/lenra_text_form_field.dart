import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

enum LenraTextFormFieldType {
  Password,
  Email,
}

Function emailValidator(Function aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 2, max: 64),
      checkEmailFormat(),
      (aditionalValidator != null) ? aditionalValidator() : (String value) {},
    ],
  );
}

Function passwordValidator(Function aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 8, max: 64),
      checkPassword(),
      (aditionalValidator != null) ? aditionalValidator() : (String value) {},
    ],
  );
}

class LenraTextFormField extends FormField<String> {
  final String label;
  final String hintText;
  final String description;
  final String errorMessage;
  final LenraTextFormFieldType type;
  final bool obscure;
  final bool disabled;
  final bool inRow;
  final Function onEditingComplete;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final LenraComponentSize size;
  final Function onSuffixPressed;
  final double width;
  final FocusNode focusNode;

  LenraTextFormField({
    Key key,
    String initialValue = "",
    validator,
    this.label = "",
    this.hintText = "",
    this.description = "",
    this.errorMessage,
    this.type,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.size = LenraComponentSize.Medium,
    this.onSuffixPressed,
    this.width,
    this.focusNode,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: (type == LenraTextFormFieldType.Email)
              ? emailValidator(validator)
              : (type == LenraTextFormFieldType.Password)
                  ? passwordValidator(validator)
                  : validator,
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
              onChanged: field.didChange,
              size: size,
              width: width,
              focusNode: focusNode,
              onSuffixPressed: onSuffixPressed,
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
