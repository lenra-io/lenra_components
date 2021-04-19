import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/profile_page/change_password_form.dart';
import 'package:fr_lenra_client/redux/models/change_password_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class ChangePasswordFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangePasswordModel>(
      converter: (store) => ChangePasswordModel(store),
      builder: (context, changePasswordModel) {
        return ChangePasswordForm(changePasswordModel: changePasswordModel);
      },
    );
  }
}
