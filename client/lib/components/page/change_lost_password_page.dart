import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/change_lost_password_form_container.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';

class ChangeLostPasswordPage extends StatelessWidget {
  static const routeName = "/lost-password";

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context).settings.arguments;
    return SimplePage(
      title: "Re-définissez un mot de passe pour votre compte Lenra",
      child: ChangeLostPasswordFormContainer(email: email),
    );
  }
}
