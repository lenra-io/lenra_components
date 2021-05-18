import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/login_form_container.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text("Connexion"),
              Container(
                child: LoginFormContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
