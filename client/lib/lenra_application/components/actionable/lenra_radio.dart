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
  final String label;
  final String value;
  final String groupValue;
  final bool disabled;
  final Map<String, dynamic> listeners;

  LenraApplicationRadio({this.value, this.label, this.groupValue, this.disabled, this.listeners}) : super();

  void onChanged(String newValue, BuildContext context) {
    if (this.listeners != null) {
      final Map<String, dynamic> listener = this.listeners['onChange'];
      if (listener != null) {
        LenraOnChangeEvent(code: listener['code'], event: {
          "value": newValue,
        }).dispatch(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraRadio<String>(
      value: this.value,
      label: this.label,
      groupValue: this.groupValue,
      disabled: this.disabled ?? false,
      onChanged: (String newValue) => this.onChanged(newValue, context),
    );
  }
}
