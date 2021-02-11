import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/verify_code_page/verify_code_form.dart';
import 'package:fr_lenra_client/redux/models/verify_code_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class VerifyCodeFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerifyCodeModel>(
      converter: (store) => VerifyCodeModel(store),
      builder: (context, verifyCodeModel) {
        return VerifyCodeForm(verifyCodeModel: verifyCodeModel);
      },
    );
  }
}
