import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_change_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LenraCheckboxState extends LenraComponentState
    implements LenraActionable {
  LenraCheckboxState(
      {String id,
      LenraComponentState parent,
      Map<String, dynamic> properties,
      Map<String, dynamic> styles})
      : super(id: id, parent: parent, properties: properties, styles: styles);

  @override
  Widget build(BuildContext context) {
    Function(bool) onChange = (bool value) {
      this.properties['value'] = value;
      if (this.properties['listeners'] != null) {
        final Map<String, dynamic> listener =
            this.properties['listeners']['onChange'];
        if (listener != null) {
          LenraOnChangeEvent(code: listener['code'], event: {'value': value})
              .dispatch(context);
        }
      }
    };

    if (this.properties['label'] == null) {
      //TODO: make the server return a boolean and not a string to remove the `== 'true'`
      return Checkbox(
          value: this.properties['value'] == 'true', onChanged: onChange);
    } else {
      return CheckboxListTile(
        value: this.properties['value'] == 'true',
        onChanged: (bool value) {
          setState(() {
            this.properties['value'] = value;
          });
          onChange(value);
        },
        title: Text(this.properties['label']),
      );
    }
  }
}
