import 'package:flutter/material.dart';
import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  var store = await LenraStore.loadStore();

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
