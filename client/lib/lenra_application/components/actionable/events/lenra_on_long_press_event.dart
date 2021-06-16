import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';

class LenraOnLongPressEvent extends LenraEvent {
  LenraOnLongPressEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
