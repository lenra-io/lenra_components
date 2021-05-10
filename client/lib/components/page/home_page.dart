import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Text("Lenra est en cours de développement"),
        ),
      ),
    );
  }
}
