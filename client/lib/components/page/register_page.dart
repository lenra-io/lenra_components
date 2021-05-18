import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/register_page/register_form_container.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo-vertical.png",
                  height: 104.0,
                ),
                SizedBox(height: 50),
                RegisterFormContainer(),
              ],
            ),
            constraints: BoxConstraints(maxWidth: 400),
          ),
        ),
      ),
    );
  }
}
