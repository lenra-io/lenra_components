import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_change_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

// TODO : generate this from annotation on LenraCheckbox
extension LenraCheckboxExt on LenraCheckbox {
  static LenraCheckbox create({value, listeners, label}) {
    return LenraCheckbox(value: value, listeners: listeners, label: label);
  }

  static const Map<String, String> propsTypes = {
    "value": "bool",
    "listeners": "Map<String, dynamic>",
    "label": "String"
  };
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
