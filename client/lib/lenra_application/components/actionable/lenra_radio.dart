import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_change_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio.dart';

// TODO : generate this from annotation on LenraRadio
class LenraRadioBuilder extends LenraComponentBuilder<LenraApplicationRadio> {
  LenraApplicationRadio map({value, label, groupValue, disabled, listeners}) {
    return LenraApplicationRadio(
      value: value,
      label: label,
      groupValue: groupValue,
      disabled: disabled,
      listeners: listeners,
    );
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "label": "String",
      "groupValue": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationRadio extends StatelessLenraComponent implements LenraActionable {
  final String value;
  final String groupValue;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? listeners;

  LenraApplicationRadio({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.disabled,
    required this.listeners,
  });

  void onChanged(String? newValue, BuildContext context) {
    final Map<String, String>? listener = this.listeners?['onChange'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnChangeEvent(code: listener['code']!, event: {
        "value": newValue,
      }).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraRadio<String>(
      value: this.value,
      label: this.label,
      groupValue: this.groupValue,
      disabled: this.disabled ?? false,
      onChanged: (String? newValue) => this.onChanged(newValue, context),
    );
  }
}
