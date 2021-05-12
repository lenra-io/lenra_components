import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          padding: EdgeInsets.all(16.0),
          width: min(MediaQuery.of(context).size.width * 0.9, 600),
          child: Text(
            "Lenra est en cours de développement",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
