import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/change_lost_password_form_container.dart';

class ChangeLostPasswordPage extends StatelessWidget {
  static const routeName = "/lost-password";

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text("Modification du mot de passe"),
              Container(
                child: ChangeLostPasswordFormContainer(email: email),
              )
            ],
          ),
        ),
      ),
    );
  }
}
