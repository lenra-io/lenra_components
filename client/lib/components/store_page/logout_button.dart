import 'package:flutter/material.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<AuthModel>().logout(),
      child: Text('Logout'),
    );
  }
}
