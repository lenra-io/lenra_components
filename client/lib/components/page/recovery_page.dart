import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/recovery_form_container.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';

class RecoveryPage extends StatelessWidget {
  static const routeName = "/recovery";

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Oublier son mot de passe ça arrive, même aux meilleurs !",
      backInkText: "Revenir à la page de connexion",
      backInkAction: () {
        Navigator.pushNamed(context, LoginPage.routeName);
      },
      child: RecoveryFormContainer(),
    );
  }
}
