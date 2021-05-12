import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/redux/models/activation_code_model.dart';

class ActivationCodeForm extends StatefulWidget {
  final ActivationCodeModel activationCodeModel;

  ActivationCodeForm({this.activationCodeModel});

  @override
  _ActivationCodeFormState createState() {
    return _ActivationCodeFormState(activationCodeModel: this.activationCodeModel);
  }
}

class _ActivationCodeFormState extends State<ActivationCodeForm> {
  final ActivationCodeModel activationCodeModel;

  _ActivationCodeFormState({this.activationCodeModel});

  final _formKey = GlobalKey<FormState>();
  String code;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        LenraTextField(
          label: 'Code :',
          description: 'Entrer votre code',
          onChanged: (String value) {
            code = value;
          },
          // validator: validator([
          //   checkNotEmpty(error: "Merci de rentrer votre code"),
          //   checkLength(
          //     min: 8,
          //     max: 100,
          //     error: "Doit contenir au moins 8 caractères",
          //   ),
          // ]),
        ),
        Padding(padding: const EdgeInsets.only(top: 16.0)),
        LenraButton(
          text: 'Devenir développeur',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              this.activationCodeModel.fetchData(body: ActivationCodeRequest(code));
            }
          },
        ),
      ]),
    );
  }
}
