import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/login_page/login_form_container.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: LoginFormContainer(),
    );
  }
}
