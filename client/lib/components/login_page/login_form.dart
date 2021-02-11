import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/redux/models/login_model.dart';
import 'package:fr_lenra_client/services/form_validators_service.dart';

class LoginForm extends StatefulWidget {
  final LoginModel loginModel;

  LoginForm({this.loginModel});

  @override
  _LoginFormState createState() {
    return _LoginFormState(loginModel: this.loginModel);
  }
}

class _LoginFormState extends State<LoginForm> {
  final LoginModel loginModel;

  _LoginFormState({this.loginModel}) : super();

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loginModel.status.isFetching) {
      return CircularProgressIndicator();
    }

    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(hintText: 'Entrez votre email', labelText: 'Email :'),
            onChanged: (String value) {
              email = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
              checkEmailFormat(),
            ]),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Entrez votre mot de passe',
              labelText: 'Mot de passe :',
            ),
            obscureText: true,
            onChanged: (String value) {
              password = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 8, max: 64),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: RichText(
              text: new TextSpan(
                text: "Pas inscrit? Créer mon compte",
                style: new TextStyle(color: Colors.blue),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/register');
                  },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      this.loginModel.fetchData(body: LoginRequest(email, password));
                    }
                  },
                  child: Text('Se Connecter')))
        ]));
  }
}