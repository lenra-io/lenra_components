import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/redux/models/register_model.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

import '../../lenra_components/theme/lenra_text_theme_data.dart';
import '../../lenra_components/theme/lenra_theme.dart';

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
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Créez votre compte utilisateur",
            style: finalLenraTextThemeData.headline2,
          ),
          SizedBox(height: 40),
          this.fields(context),
          SizedBox(height: 35),
          //------Button------
          this.validationButton(context),
          SizedBox(height: 35),
          Text(
            "Lenra est une plateforme d’application en version alpha, des bugs ou des fonctionnalités peuvent être manquantes.",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.bodyText.merge(
              TextStyle(
                color: Color(0xFF8B97AD),
              ),
            ),
          ),

          ErrorList(this.registerModel.errors)
        ],
      ),
    );
  }

  Widget validationButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LenraButton(
        text: "Créer mon compte Lenra",
        size: LenraButtonSize.Large,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            this.registerModel.register(
                  RegisterRequest(
                    this.email,
                    this.password,
                  ),
                );
          }
        },
      ),
    );
  }

  Widget fields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //------Email------
        LenraTextFormField(
          label: 'Définissez un identifiant de connexion',
          hintText: 'email@email.com',
          onChanged: (String value) {
            email = value;
          },
          size: LenraTextFieldSize.Large,
          validator: validator([
            checkNotEmpty(),
            checkLength(min: 2, max: 64),
            checkEmailFormat(),
          ]),
        ),
        SizedBox(height: 20),
        //------Password------
        LenraTextFormField(
          label: 'Définissez un mot de passe',
          description: "8 caractères, 1 majuscule, 1 minuscule et 1 caractère spécial.",
          obscure: _passwordVisible,
          onChanged: (String value) {
            password = value;
          },
          size: LenraTextFieldSize.Large,
          validator: validator([
            checkNotEmpty(),
            checkLength(min: 8, max: 64),
            checkPassword(),
          ]),
        ),
      ],
    );
  }
}
