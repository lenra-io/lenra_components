import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/register_page/register_form.dart';
import 'package:fr_lenra_client/redux/models/register_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class RegisterFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RegisterModel>(
      converter: (store) => RegisterModel(store),
      builder: (context, registerModel) {
        return RegisterForm(registerModel: registerModel);
      },
    );
  }
}
