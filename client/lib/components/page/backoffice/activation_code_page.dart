import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/activation_code_page/activation_code_form_container.dart';

class ActivationCodePage extends StatelessWidget {
  static const routeName = '/activate-dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: min(MediaQuery.of(context).size.width * 0.9, 600),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text(
                "Merci pour votre inscription",
                textAlign: TextAlign.center,
              ),
              Container(
                child: Wrap(direction: Axis.horizontal, alignment: WrapAlignment.spaceEvenly, children: [
                  Text(
                    "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès.",
                    textAlign: TextAlign.center,
                  ),
                  ActivationCodeFormContainer(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
