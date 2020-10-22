import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/config/config.dart';

void main() {
  Config.create(
    serverHost:
        const String.fromEnvironment("SERVER_HOST", defaultValue: "localhost"),
    serverPort: const int.fromEnvironment("SERVER_PORT", defaultValue: 4000),
    secure: const bool.fromEnvironment("SECURE", defaultValue: false),
  );

  start();
}
