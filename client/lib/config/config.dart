import 'config_getter_stub.dart'
    if (dart.library.io) 'config_getter_io.dart'
    if (dart.library.js) 'config_getter_web.dart';

class Config {
  static final Config instance = createInstance();

  final String httpEndpoint;
  final String wsEndpoint;
  final String basicAuth;

  Config._(
    this.httpEndpoint,
    this.wsEndpoint,
    this.basicAuth,
  );

  static Config createInstance() {
    String httpEndpoint = const String.fromEnvironment("LENRA_SERVER_URL");
    if (httpEndpoint.isEmpty) {
      httpEndpoint = getServerUrl();
    }
    String wsEndpoint = httpEndpoint.replaceFirst(new RegExp("^http"), "ws");
    wsEndpoint += "/socket/websocket";
    String basicAuth = const String.fromEnvironment("LENRA_BASIC_AUTH");
    return Config._(
      httpEndpoint,
      wsEndpoint,
      basicAuth,
    );
  }
}
