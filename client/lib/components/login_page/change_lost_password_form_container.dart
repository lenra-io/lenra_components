import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/login_page/change_lost_password_form.dart';
import 'package:fr_lenra_client/redux/models/change_lost_password_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class ChangeLostPasswordFormContainer extends StatelessWidget {
  final String email;

  ChangeLostPasswordFormContainer({this.email});
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangeLostPasswordModel>(
      converter: (store) => ChangeLostPasswordModel(store),
      builder: (context, changeLostPasswordModel) {
        return ChangeLostPasswordForm(changeLostPasswordModel: changeLostPasswordModel, email: email);
      },
    );
  }
}
