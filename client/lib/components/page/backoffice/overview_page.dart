import 'dart:math';

import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          padding: EdgeInsets.all(16.0),
          width: min(MediaQuery.of(context).size.width * 0.9, 600),
          child: Text(
            "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
