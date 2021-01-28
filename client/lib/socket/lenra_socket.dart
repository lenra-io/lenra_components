library socket;

import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'socket_manager_stub.dart'
    if (dart.library.io) 'socket_manager_io.dart'
    if (dart.library.js) 'socket_manager_web.dart';

class LenraSocket {
  static PhoenixSocket _socket;

  static final LenraSocket _instance = LenraSocket._privateConstructor();

  LenraSocket._privateConstructor() {
    LenraSocket._socket = createPhoenixSocket(Config.instance.wsEndpoint);
    _socket.connect();
  }

  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    return new LenraChannel(LenraSocket._socket, channelName, params);
  }

  void close() {
    _socket.disconnect();
  }

  void emit() {}

  static LenraSocket get instance => _instance;
}
