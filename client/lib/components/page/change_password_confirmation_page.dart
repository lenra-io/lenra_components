import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/home_page.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';

class ChangePasswordConfirmationPage extends StatelessWidget {
  static const routeName = "/change-confirmation";

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Votre nouveau mot de passe a été correctement enregistré !",
      child: SizedBox(
        width: double.infinity,
        child: LenraButton(
          text: "Continuer sur  Lenra",
          onPressed: () {
            Navigator.pushNamed(context, HomePage.routeName);
          },
        ),
      ),
    );
  }
}
