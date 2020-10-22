import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_event.dart';

class LenraOnSubmitEvent extends LenraEvent {
  LenraOnSubmitEvent(
      {@required String code, @required Map<String, dynamic> event})
      : super(code: code, event: event);
}
