import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/register_page/register_form_container.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

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
              Text("Inscription"),
              Container(
                child: RegisterFormContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
