import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_long_press_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_press_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_submit_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

// TODO : generate this from annotation on LenraButton
extension LenraButtonExt on LenraButton {
  static LenraButton create({value, listeners}) {
    return LenraButton(value: value, listeners: listeners);
  }

  static const Map<String, String> propsTypes = {
    "value": "String",
    "listeners": "Map<String, dynamic>"
  };
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
    return OutlineButton(
      child: Text(this.value),
      borderSide: BorderSide(color: Theme.of(context).buttonColor),
      onPressed: () => this.onPressed(context),
      onLongPress: () => this.onLongPress(context),
    );
  }
}
