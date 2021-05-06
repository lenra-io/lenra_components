import 'connexion_utils_stub.dart'
    if (dart.library.io) 'connexion_utils_io.dart'
    if (dart.library.js) 'connexion_utils_web.dart';

enum Application { app, dev }

class Config {
  static final Config instance = createInstance();

  final Application application;
  final String httpEndpoint;
  final String wsEndpoint;
  final String basicAuth;

  Config._(
    this.application,
    this.httpEndpoint,
    this.wsEndpoint,
    this.basicAuth,
  );

  static Config createInstance() {
    String httpEndpoint = const String.fromEnvironment("LENRA_SERVER_URL");
    if (httpEndpoint.isEmpty) {
      httpEndpoint = getServerUrl();
    }
    String appName = const String.fromEnvironment("LENRA_APPLICATION");
    if (appName.isEmpty) {
      appName = httpEndpoint.replaceAllMapped(new RegExp("^https?://([^/.]+)([/.].*)?\$"), (match) {
        return match.group(1);
      });
    }
    String wsEndpoint = httpEndpoint.replaceFirst(new RegExp("^http"), "ws");
    wsEndpoint += "/socket/websocket";
    String basicAuth = const String.fromEnvironment("LENRA_BASIC_AUTH");
    return Config._(
      Application.values.firstWhere((a) => a.toString() == "Application.$appName", orElse: () => Application.app),
      httpEndpoint,
      wsEndpoint,
      basicAuth,
    );
  }
}
