import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Lenra est en cours de développement",
      child: Text(
        "Pour accéder à une application vous devez avoir son chemin d'accès fournis par son créateur.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
