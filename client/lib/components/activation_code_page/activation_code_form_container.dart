import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/activation_code_page/activation_code_form.dart';
import 'package:fr_lenra_client/redux/models/activation_code_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class ActivationCodeFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ActivationCodeModel>(
      converter: (store) => ActivationCodeModel(store),
      builder: (context, activationCodeModel) {
        return ActivationCodeForm(activationCodeModel: activationCodeModel);
      },
    );
  }
}
