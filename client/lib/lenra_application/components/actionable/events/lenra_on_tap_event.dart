import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';

class LenraOnTapEvent extends LenraEvent {
  LenraOnTapEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
