import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/recovery_form.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';

class RecoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Oublier son mot de passe ça arrive, même aux meilleurs !",
      backInkText: "Revenir à la page de connexion",
      backInkAction: () {
        Navigator.pushNamed(context, LenraNavigator.HOME_ROUTE);
      },
      child: RecoveryForm(),
    );
  }
}
