import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/loading_button.dart';
import 'package:fr_lenra_client/redux/models/change_lost_password_model.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

class ChangeLostPasswordForm extends StatefulWidget {
  final ChangeLostPasswordModel changeLostPasswordModel;
  final String email;

  ChangeLostPasswordForm({this.changeLostPasswordModel, this.email});

  @override
  _ChangeLostPasswordState createState() {
    return _ChangeLostPasswordState();
  }
}

class _ChangeLostPasswordState extends State<ChangeLostPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String code;
  String newPassword;
  String newPasswordConfirmation;

  bool _passwordVisible;
  bool _passwordVisibleConfirm;

  @override
  void initState() {
    _passwordVisible = true;
    _passwordVisibleConfirm = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (this.widget.email == null)
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrer votre email',
                labelText: 'Email:',
              ),
              onChanged: (String value) {
                this.code = value;
              },
              validator: validator([
                checkNotEmpty(error: "Merci de rentrer votre Email"),
                checkLength(min: 2, max: 64),
                checkEmailFormat(),
              ]),
            ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entrer votre code',
              labelText: 'Code :',
            ),
            onChanged: (String value) {
              this.code = value;
            },
            validator: validator([
              checkNotEmpty(error: "Merci de rentrer votre code"),
              checkLength(
                min: 8,
                max: 8,
                error: "Doit contenir 8 caractères",
              ),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Entrez votre nouveau mot de passe',
              labelText: 'Nouveau mot de passe :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            obscureText: _passwordVisible,
            onChanged: (String value) {
              setState(() {
                this.newPassword = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Confirmation du nouveau mot de passe',
              labelText: 'Nouveau mot de passe :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisibleConfirm ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisibleConfirm = !_passwordVisibleConfirm;
                  });
                },
              ),
            ),
            obscureText: _passwordVisibleConfirm,
            onChanged: (String value) {
              setState(() {
                this.newPasswordConfirmation = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LoadingButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this.widget.changeLostPasswordModel.fetchData(
                      body: ChangeLostPasswordRequest(
                          this.code, this.widget.email, this.newPassword, this.newPasswordConfirmation));
                }
              },
              child: Text('Confirmer'),
              loading: this.widget.changeLostPasswordModel.status.isFetching,
            ),
          ),
          ErrorList(this.widget.changeLostPasswordModel.errors),
        ],
      ),
    );
  }
}
