library socket;

import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/config/connexion_utils_stub.dart'
    if (dart.library.io) 'package:fr_lenra_client/config/connexion_utils_io.dart'
    if (dart.library.js) 'package:fr_lenra_client/config/connexion_utils_web.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class LenraSocket {
  static PhoenixSocket _socket;

  static LenraSocket _instance;

  LenraSocket._privateConstructor(Map<String, String> params) {
    LenraSocket._socket = createPhoenixSocket(
      Config.instance.wsEndpoint,
      params,
    );
  }

  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    return new LenraChannel(LenraSocket._socket, channelName, params);
  }

  void connect() {
    _socket.connect();
  }

  void close() {
    _socket.disconnect();
  }

  void emit() {}

  static LenraSocket createInstance(String token) {
    _instance?.close();

    LenraSocket._instance = LenraSocket._privateConstructor({"token": token});
    return _instance;
  }

  static LenraSocket get instance => _instance;
}
