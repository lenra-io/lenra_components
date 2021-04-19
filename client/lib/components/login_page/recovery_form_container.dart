import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/login_page/recovery_form.dart';
import 'package:fr_lenra_client/redux/models/recovery_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class RecoveryFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecoveryModel>(
      converter: (store) => RecoveryModel(store),
      builder: (context, recoveryModel) {
        return RecoveryForm(recoveryModel: recoveryModel);
      },
    );
  }
}
