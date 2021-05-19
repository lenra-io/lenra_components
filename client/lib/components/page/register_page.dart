import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/components/register_page/register_form_container.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      backInkText: "Revenir à la page de connexion",
      backInkAction: () {
        Navigator.pushNamed(context, LoginPage.routeName);
      },
      title: "Créez votre compte utilisateur",
      child: RegisterFormContainer(),
    );
  }
}
