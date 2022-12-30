import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_components/utils/form_validators.dart';

enum LenraTextFormFieldType {
  password,
  email,
  normal,
}

Function emailValidator(Function? aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 2, max: 64),
      checkEmailFormat(),
      (aditionalValidator != null)
          ? aditionalValidator()
          : (String? value) {
              return null;
            },
    ],
  );
}

Function passwordValidator(Function? aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 8, max: 64),
      checkPassword(),
      (aditionalValidator != null)
          ? aditionalValidator()
          : (String? value) {
              return null;
            },
    ],
  );
}

class LenraTextFormField extends FormField<String> {
  final String? label;
  final String? hintText;
  final String? description;
  final String? errorMessage;
  final LenraTextFormFieldType type;
  final bool obscure;
  final bool disabled;
  final bool inRow;
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

  LenraTextFormField({
    Key? key,
    String initialValue = "",
    validator,
    this.label = "",
    this.hintText = "",
    this.description = "",
    this.errorMessage,
    this.type = LenraTextFormFieldType.normal,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.onSubmitted,
    this.onChanged,
    this.size = LenraComponentSize.medium,
    this.onSuffixPressed,
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
        super(
          key: key,
          initialValue: initialValue,
          validator: (type == LenraTextFormFieldType.email)
              ? emailValidator(validator)
              : (type == LenraTextFormFieldType.password)
                  ? passwordValidator(validator)
                  : validator,
          builder: (FormFieldState field) {
            bool hasError = errorMessage != null && errorMessage != "";
            return LenraTextField(
              label: label,
              hintText: hintText,
              description: description,
              errorMessage: hasError ? errorMessage : field.errorText,
              obscure: obscure,
              disabled: disabled,
              inRow: inRow,
              error: hasError ? true : field.hasError,
              onChanged: field.didChange,
              size: size,
              width: width,
              minLines: minLines,
              maxLines: maxLines,
              focusNode: focusNode,
              onSuffixPressed: onSuffixPressed,
              controller: controller,
              autofillHints: autofillHints,
              onSubmitted: onSubmitted,
            );
          },
        );

  @override
  FormFieldState<String> createState() => _LenraTextFormField();
}

class _LenraTextFormField extends FormFieldState<String> {
  @override
  LenraTextFormField get widget => super.widget as LenraTextFormField;

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (widget.onChanged == null || value == null) return;
    widget.onChanged!(value);
  }
}
