import 'package:flutter/material.dart';

class LenraComponentsShowcase extends StatelessWidget {
  static const routeName = "/showcase";

  Row buildButton(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(onPressed: () => false, child: Text("Test")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildButton(context),
        ],
      ),
    );
  }
}
