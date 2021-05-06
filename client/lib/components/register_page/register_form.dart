import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/loading_button.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/redux/models/register_model.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

class RegisterForm extends StatefulWidget {
  final RegisterModel registerModel;

  RegisterForm({this.registerModel});

  @override
  _RegisterFormState createState() {
    return _RegisterFormState(registerModel: this.registerModel);
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final RegisterModel registerModel;

  _RegisterFormState({this.registerModel}) : super();

  final _formKey = GlobalKey<FormState>();
  String email;
  String firstName;
  String lastName;
  String password;

  bool _passwordVisible;

  String getPassword() => this.password;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //------Email------
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entrer votre email',
              labelText: 'Email :',
            ),
            onChanged: (String value) {
              email = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
              checkEmailFormat(),
            ]),
          ),
          //------FirstName------
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entrer votre Prénom',
              labelText: 'Prénom :',
            ),
            onChanged: (String value) {
              firstName = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
            ]),
          ),
          //------LastName------
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entrer votre Nom',
              labelText: 'Nom',
            ),
            onChanged: (String value) {
              lastName = value;
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
            ]),
          ),
          //------Password------
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Entrer votre mot de passe',
              labelText: 'Mot de passe :',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                text: "Déjà inscrit? Se connecter",
                style: new TextStyle(color: Colors.blue),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(context, LoginPage.routeName);
                  },
              ),
            ),
          ),
          //------Button------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LoadingButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this.registerModel.register(
                        RegisterRequest(
                          this.email,
                          this.firstName,
                          this.lastName,
                          this.password,
                        ),
                      );
                }
              },
              child: Text('Submit'),
              loading: this.registerModel.status.isFetching,
            ),
          ),
          ErrorList(this.registerModel.errors)
        ],
      ),
    );
  }
}
