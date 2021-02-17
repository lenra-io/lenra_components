import 'package:flutter/material.dart';
import 'package:fr_lenra_client/redux/models/logout_button_model.dart';

class LogoutButton extends StatelessWidget {
  final LogoutButtonModel logoutButtonModel;

  LogoutButton({this.logoutButtonModel});

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.logoutButtonModel.fetchData,
      child: Text('Logout'),
    );
  }
}
