import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/recovery_form_container.dart';

class RecoveryPage extends StatelessWidget {
  static const routeName = "/recovery";

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
              Text("Récuperation du mot de passe"),
              Text("Entrez l'adresse email du compte à récupérer"),
              Container(
                child: RecoveryFormContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
