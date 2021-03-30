import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_change_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder extends LenraComponentBuilder<LenraCheckbox> {
  LenraCheckbox map({value, listeners, label}) {
    return LenraCheckbox(value: value, listeners: listeners, label: label);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "bool",
      "listeners": "Map<String, dynamic>",
      "label": "String",
    };
  }
}

class LenraCheckbox extends StatefulLenraComponent implements LenraActionable {
  final String label;
  final bool value;
  final Map<String, dynamic> listeners;

  LenraCheckbox({this.value, this.listeners, this.label}) : super();

  @override
  State<StatefulWidget> createState() {
    return _LenraCheckboxState(value: this.value, listeners: this.listeners);
  }
}

class _LenraCheckboxState extends LenraComponentState {
  String label;
  bool value;
  Map<String, dynamic> listeners;
  _LenraCheckboxState({@required this.value, this.listeners, this.label}) : super();

  @override
  Widget build(BuildContext context) {
    Function(bool) onChange = (bool value) {
      this.value = value;
      if (this.listeners != null) {
        final Map<String, dynamic> listener = this.listeners['onChange'];
        if (listener != null) {
          LenraOnChangeEvent(code: listener['code'], event: {'value': value}).dispatch(context);
        }
      }
    };

    return CheckboxListTile(
      value: this.value,
      onChanged: (bool value) {
        setState(() {
          this.value = value;
        });
        onChange(value);
      },
      title: Text(this.label),
    );
  }
}
