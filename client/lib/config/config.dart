class Config {
  Config._({
    this.serverHost,
    this.serverPort,
    this.secure,
  }) {
    if (_instance == null) {
      Config._instance = this;
    } else {
      throw Exception("La config ne doit être instanciée qu'une seule fois.");
    }
    String httpScheme = this.secure ? "https" : "http";
    httpEndpoint = "$httpScheme://$serverHost:$serverPort/";
    String wsScheme = this.secure ? "wss" : "ws";
    wsEndpoint = "$wsScheme://$serverHost:$serverPort/socket/websocket";
  }

  factory Config.create({String serverHost, int serverPort, bool secure}) {
    return Config._(
      serverHost: serverHost,
      serverPort: serverPort,
      secure: secure,
    );
  }

  static Config _instance;
  final String serverHost;
  final int serverPort;
  final bool secure;
  String httpEndpoint;
  String wsEndpoint;

  static Config get instance => _instance;
}
