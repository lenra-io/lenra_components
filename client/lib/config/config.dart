import 'package:flutter/services.dart';
import 'dart:js';

class Config {
  Config._(this.httpEndpoint) {
    if (_instance == null) {
      Config._instance = this;
    } else {
      throw Exception("La config ne doit être instanciée qu'une seule fois.");
    }
    String url = httpEndpoint;
    if (url.isEmpty) {
      url = context['location']['origin'];
    }
    wsEndpoint = "${url.replaceFirst(new RegExp("^http"), "ws")}/socket/websocket";
  }

  factory Config.create(String serverUrl) {
    return Config._(serverUrl);
  }

  static Config _instance;
  final String httpEndpoint;
  String wsEndpoint;

  static Config get instance => _instance;
}
