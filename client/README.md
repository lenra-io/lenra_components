# Lenra Client

The Lenra Client in Flutter

### Prérequis
- [flutter](https://flutter.dev/docs/get-started/install) + [web setup](https://flutter.dev/docs/get-started/web)

## Getting Started

Run flutter app with chrome
```sh
flutter run -d chrome --dart-define=LENRA_SERVER_URL=http://localhost:4000
```

run flutter test
```sh
flutter test
```

run flutter test with coverage report (need to install lcov)
```sh
flutter test --coverage && lcov --list coverage/lcov.info
```

