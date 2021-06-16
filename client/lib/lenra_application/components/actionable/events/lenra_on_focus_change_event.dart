import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';

class LenraOnFocusChangeEvent extends LenraEvent {
  LenraOnFocusChangeEvent({
    required String code,
    required Map<String, dynamic> event,
  }) : super(code: code, event: event);
}
