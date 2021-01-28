import 'package:phoenix_wings/html.dart';

PhoenixSocket createPhoenixSocket(String endpoint) => new PhoenixSocket(
      endpoint,
      connectionProvider: PhoenixHtmlConnection.provider,
    );
