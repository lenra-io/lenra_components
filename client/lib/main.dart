import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/config/config.dart';

void main() {
  Config.create(const String.fromEnvironment("SERVER_URL"));

  start();
}
