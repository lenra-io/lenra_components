import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/redux/models/verify_code_model.dart';
import 'package:fr_lenra_client/services/form_validators_service.dart';

class VerifyCodeForm extends StatefulWidget {
  final VerifyCodeModel verifyCodeModel;

  VerifyCodeForm({this.verifyCodeModel});

  @override
  _VerifyCodeFormState createState() {
    return _VerifyCodeFormState(verifyCodeModel: this.verifyCodeModel);
  }
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  final VerifyCodeModel verifyCodeModel;

  _VerifyCodeFormState({this.verifyCodeModel});

  final _formKey = GlobalKey<FormState>();
  String code;

  @override
  void initState() {
    super.initState();
  }

  Widget buildTextInput(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Entrer votre code',
        labelText: 'Code :',
      ),
      onChanged: (String value) {
        code = value;
      },
      validator: validator([
        checkNotEmpty(error: "Merci de rentrer votre code"),
        checkLength(
          min: 8,
          max: 8,
          error: "Doit contenir 8 caractères",
        ),
      ]),
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            this.verifyCodeModel.fetchData(body: VerifyCodeRequest(code));
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            this.buildTextInput(context),
            this.buildButton(context),
          ]),
    );
  }
}
