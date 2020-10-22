import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/config/config.dart';

void main() {
  Config.create(
    serverHost: "www.lenra.me",
    serverPort: 443,
    secure: true,
  );

  start();
}
