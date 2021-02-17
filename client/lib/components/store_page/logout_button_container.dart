import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/store_page/logout_button.dart';
import 'package:fr_lenra_client/redux/models/logout_button_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class LogoutButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LogoutButtonModel>(
      converter: (store) => LogoutButtonModel(store),
      builder: (context, logoutButtonModel) {
        return LogoutButton(logoutButtonModel: logoutButtonModel);
      },
    );
  }
}
