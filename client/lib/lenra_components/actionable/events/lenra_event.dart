//? Here is defined all Event types that can be send to the server.
import 'package:flutter/material.dart';

class LenraEvent extends Notification {
  LenraEvent({@required this.code, this.event}) : super();
  final String code;
  final Map<String, dynamic> event;

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "event": event,
    };
  }
}
