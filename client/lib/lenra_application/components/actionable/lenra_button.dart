import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_press_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_submit_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraApplicationButton> {
  LenraApplicationButton map({value, disabled, listeners}) {
    return LenraApplicationButton(value: value, disabled: disabled, listeners: listeners);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationButton extends StatelessLenraComponent implements LenraActionable {
  final String value;
  final bool disabled;
  final Map<String, dynamic> listeners;

  LenraApplicationButton({@required this.value, this.disabled, this.listeners}) : super();

  void onPressed(BuildContext context) {
    if (this.listeners != null) {
      final Map<String, dynamic> listener = this.listeners['onClick'];
      if (listener != null) {
        LenraOnPressEvent(code: listener['code'], event: {}).dispatch(context);
      }
      //? If This button is inside of a LenraForm, this push the notification to it.
      LenraOnSubmitEvent(code: null, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraButton(
      text: this.value,
      disabled: this.disabled ?? false,
      onPressed: () => this.onPressed(context),
    );
  }
}
