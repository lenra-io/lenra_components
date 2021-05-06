import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
              "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès."),
        ),
      ),
    );
  }
}
