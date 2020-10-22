library socket;

import 'dart:async';
import 'dart:developer';

import 'package:phoenix_wings/html.dart';

class LenraChannel {
  PhoenixChannel _channel;
  Map<String, StreamController<Map<String, dynamic>>> _streamControllers =
      Map();

  LenraChannel(
      PhoenixSocket socket, String channelName, Map<String, dynamic> params) {
    _channel = socket.channel(channelName, params);
    _channel.join();
  }

  void close() {
    _streamControllers
        .forEach((String event, StreamController streamController) {
      streamController.close();
    });
    _channel.leave();
  }

  StreamController<Map<String, dynamic>> _createStreamController(String event) {
    StreamController<Map<String, dynamic>> streamController =
        StreamController();
    _channel.on(event, (
      Map<dynamic, dynamic> payload,
      String ref,
      String joinRef,
    ) {
      log("Message received : $event -> ${payload.toString()}");
      streamController.sink.add(payload as Map<String, dynamic>);
    });

    return streamController;
  }

  StreamController<Map<String, dynamic>> getStreamController(String event) {
    if (_streamControllers.containsKey(event)) {
      return _streamControllers[event];
    } else {
      _streamControllers[event] = this._createStreamController(event);
      return _streamControllers[event];
    }
  }

  void send(String event, dynamic data) {
    this._channel.push(event: event, payload: data as Map<dynamic, dynamic>);
  }
}
