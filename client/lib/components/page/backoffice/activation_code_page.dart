import 'package:flutter/material.dart';

class ActivationCodePage extends StatelessWidget {
  static const routeName = '/activate-dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text("Merci pour votre inscription"),
              Container(
                child: Wrap(direction: Axis.horizontal, alignment: WrapAlignment.spaceEvenly, children: [
                  Text(
                      "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès."),
                  // TODO: mettre en place le formulaire
                  // VerifyCodeFormContainer(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
