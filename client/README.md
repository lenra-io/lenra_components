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

## Système de composants Lenra
### LenraSocket
Permet la gestion de la socket client. Une seule socket est ouverte pour l'ensemble de la session. L'authentification se fait à l'aide de l'access token.

### LenraChannel
Ouverture du channel pour chaque ouverture d'app. Le channel est fermé lors de la fermeture de l'app.

### LenraUiController
C'est le point d'entrée pour afficher l'app Lenra.
Il fait le lien entre le socket et le builder. C'est un StatefulWidget. 
 - Il prends en entrée un *appName* (l'identifiant/nom de l'app)
 - Il Ouvre/Ferme le **LenraChannel** en fonction de l'app
 - Il écoute les event du channel (serveur), parse les patch et envoie ces event au **LenraUiBuilder** via deux stream : 
   - Le Ui Stream pour envoyer la nouvelle UI complète (1er event)
   - Les patch pour modifier l'UI actuelle.
 - Il écoute les évennement (notif) des enfants pour les envoyer dans le channel au serveur
 - Il affiche le builder (l'app)

ex : 
```dart
class MyPage extends StatelessWidget {
    Widget build(BuildContext context) {
        return LenraUiController("myApp");
    }
}
```

### LenraUiBuilder
C'est un Stateful Widget qui s'occupe de transformer l'UI et les Patch en widget/properties utilisable : 
 - Il prend en entrée les deux stream (UI et Patch)
 - Il construit les composants **LenraWrapper**.
 - Il gère la modification des propriété par les patch.
 - Il notifie les **LenraWrapper** lorsque leurs propriétés changent.
 - Il connait toutes les propriétés et tous les **LenraWrapper** de l'app.
 - Il affiche le **LenraWrapper** correspondant au composant "root" de l'UI

### LenraWrapper
C'est le composant "intelligent" parent de tous les composants d'affichage de Lenra.
- Il instancie le composant d'affichage en fonction du type.
- Il parse les propriétés JSON en objets utile pour le composant d'affichage.
