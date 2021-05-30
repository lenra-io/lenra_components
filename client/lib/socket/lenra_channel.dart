library socket;

import 'package:phoenix_wings/phoenix_wings.dart';

class LenraChannel {
  PhoenixChannel _channel;
  List<Function> _errorCallbacks = [];
  LenraChannel(PhoenixSocket socket, String channelName, Map<String, dynamic> params) {
    _channel = socket.channel(channelName, params);
    _channel.join().receive("error", (Map response) {
      _errorCallbacks.forEach((c) {
        c();
      });
    });
  }

  void close() {
    this._channel.off("ui");
    this._channel.off("patchUi");
    _channel.leave();
  }

  void onUi(Function(Map<String, dynamic>) callback) {
    this._channel.on("ui", (payload, ref, joinRef) {
      callback(payload);
    });
  }

  void onPatchUi(Function(Map<String, dynamic>) callback) {
    this._channel.on("patchUi", (payload, ref, joinRef) {
      callback(payload);
    });
  }

  void onError(Function callback) {
    this._errorCallbacks.add(callback);
  }

  void send(String event, dynamic data) {
    this._channel.push(event: event, payload: data as Map<dynamic, dynamic>);
  }
}
