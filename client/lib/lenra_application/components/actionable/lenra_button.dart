import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_long_press_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_press_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_on_submit_event.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraButton> {
  LenraButton map({value, listeners}) {
    return LenraButton(value: value, listeners: listeners);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraButton extends StatelessLenraComponent implements LenraActionable {
  final String value;
  final Map<String, dynamic> listeners;

  LenraButton({@required this.value, this.listeners}) : super();

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

  void onLongPress(BuildContext context) {
    if (this.listeners != null) {
      final Map<String, dynamic> listener = this.listeners['onLongClick'];
      if (listener != null) {
        LenraOnLongPressEvent(code: listener['code'], event: {}).dispatch(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(this.value),
      onPressed: () => this.onPressed(context),
      onLongPress: () => this.onLongPress(context),
    );
  }
}
