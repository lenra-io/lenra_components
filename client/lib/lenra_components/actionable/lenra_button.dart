import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_long_press_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_press_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_submit_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

class LenraButtonState extends LenraComponentState implements LenraActionable {
  LenraButtonState(
      {String id,
      LenraComponentState parent,
      Map<String, dynamic> properties,
      Map<String, dynamic> styles})
      : super(id: id, parent: parent, properties: properties, styles: styles);

  void onPressed() {
    if (this.properties['listeners'] != null) {
      final Map<String, dynamic> listener =
          this.properties['listeners']['onClick'];
      if (listener != null) {
        LenraOnPressEvent(code: listener['code'], event: {}).dispatch(context);
      }
      //? If This button is inside of a LenraForm, this push the notification to it.
      LenraOnSubmitEvent(code: null, event: {}).dispatch(context);
    }
  }

  void onLongPress() {
    if (this.properties['listeners'] != null) {
      final Map<String, dynamic> listener =
          this.properties['listeners']['onLongClick'];
      if (listener != null) {
        LenraOnLongPressEvent(code: listener['code'], event: {})
            .dispatch(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(this.properties['value']),
      borderSide: BorderSide(color: Theme.of(context).buttonColor),
      onPressed: this.onPressed,
      onLongPress: this.onLongPress,
    );
  }
}
