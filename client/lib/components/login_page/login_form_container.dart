import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/login_page/login_form.dart';
import 'package:fr_lenra_client/redux/models/login_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class LoginFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginModel>(
      converter: (store) => LoginModel(store),
      builder: (context, loginModel) {
        return LoginForm(loginModel: loginModel);
      },
    );
  }
}
