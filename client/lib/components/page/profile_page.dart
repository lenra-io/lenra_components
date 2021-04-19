import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/profile_page/change_password_form_container.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile";

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
              Text("Profil"),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Text("Modification du mot de passe"),
                  Container(
                    child: ChangePasswordFormContainer(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
