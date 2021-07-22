import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_edit_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

// TODO : generate this from annotation on LenraTextfield
class LenraTextfieldBuilder extends LenraComponentBuilder<LenraApplicationTextfield> {
  LenraApplicationTextfield map({
    value,
    label,
    hintText,
    description,
    errorMessage,
    obscure,
    disabled,
    inRow,
    error,
    width,
    listeners,
    size,
  }) {
    return LenraApplicationTextfield(
      value: value,
      label: label,
      hintText: hintText,
      description: description,
      errorMessage: errorMessage,
      obscure: obscure,
      disabled: disabled,
      inRow: inRow,
      error: error,
      width: width,
      listeners: listeners,
      size: size,
    );
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "label": "String",
      "hintText": "String",
      "description": "String",
      "errorMessage": "String",
      "obscure": "bool",
      "disabled": "bool",
      "inRow": "bool",
      "error": "bool",
      "width": "double",
      "listeners": "Map<String, dynamic>",
      "size": "LenraComponentSize"
    };
  }
}

// ignore: must_be_immutable
class LenraApplicationTextfield extends StatelessLenraComponent implements LenraActionable {
  String? label;
  String? hintText;
  String? description;
  String? errorMessage;
  bool? obscure;
  bool? disabled;
  bool? inRow;
  bool? error;
  double? width;
  LenraComponentSize? size;
  final Map<String, dynamic>? listeners;
  final FocusNode _focusNode;
  final TextEditingController _controller;

  LenraApplicationTextfield({
    required String value,
    required this.label,
    required this.hintText,
    required this.description,
    required this.errorMessage,
    required this.obscure,
    required this.disabled,
    required this.inRow,
    required this.error,
    required this.width,
    required this.size,
    required this.listeners,
  })  : this._controller = TextEditingController(text: value),
        this._focusNode = FocusNode(),
        super();

  @override
  Widget build(BuildContext context) {
    return LenraTextField(
      label: this.label,
      hintText: this.hintText,
      description: this.description,
      errorMessage: this.errorMessage,
      obscure: this.obscure ?? false,
      disabled: this.disabled ?? false,
      inRow: this.inRow ?? false,
      error: this.error ?? false,
      onSubmitted: (value) {
        final Map<String, dynamic>? listener = this.listeners?['onChange'];
        if (listener != null && listener.containsKey("code")) {
          LenraOnEditEvent(code: listener['code']!, event: {'value': value}).dispatch(context);
        }
      },
      size: this.size ?? LenraComponentSize.Medium,
      width: this.width ?? 200.0,
      focusNode: this._focusNode,
      controller: this._controller,
    );
  }
}
