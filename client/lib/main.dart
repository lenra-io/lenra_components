import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  // FROM : https://stackoverflow.com/a/64634042
  // configureApp();

  debugPrint("Starting main app[debugPrint]: ${Config.instance.application}");
  var store = await LenraStore.loadStore();
  // TODO: Récupération de variables d'environnement ne doit pas marcher
  const environement = String.fromEnvironment('ENVIRONMENT');

  if (environement == "production" || environement == "staging") {
    const sentry_dsn = String.fromEnvironment('SENTRY_CLIENT_DSN');
    await SentryFlutter.init(
      (options) => options
        ..dsn = sentry_dsn
        ..environment = environement,
      appRunner: () => runApp(Lenra(store: store)),
    );
  } else {
    runApp(Lenra(store: store));
  }
}
