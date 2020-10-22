library socket;

import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/socket/lerna_channel.dart';
import 'package:phoenix_wings/html.dart';

class LenraSocket {
  static PhoenixSocket _socket;

  static final LenraSocket _instance = LenraSocket._privateConstructor();

  LenraSocket._privateConstructor() {
    LenraSocket._socket = new PhoenixSocket(Config.instance.wsEndpoint,
        connectionProvider: PhoenixHtmlConnection.provider);
    _socket.connect();
  }

  static LenraSocket get instance => _instance;

  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    return new LenraChannel(LenraSocket._socket, channelName, params);
  }

  void close() {
    _socket.disconnect();
  }

  void emit() {}
}
