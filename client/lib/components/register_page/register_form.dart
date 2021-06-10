import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/loading_button.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  bool _hidePassword = true;

  String getPassword() => this.password;

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiErrors registerErrors = context.select<AuthModel, ApiErrors>((m) => m.registerStatus.errors);
    return Form(
      key: _formKey,
      child: LenraColumn(
        separationFactor: 5,
        children: [
          this.fields(context),
          //------Button------
          this.validationButton(context),
          Text(
            "Lenra est une plateforme d’application en version alpha, des bugs ou des fonctionnalités peuvent être manquantes.",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),

          ErrorList(registerErrors)
        ],
      ),
    );
  }

  Widget validationButton(BuildContext context) {
    bool isRegistering = context.select<AuthModel, bool>((m) => m.registerStatus.isFetching());
    return SizedBox(
      width: double.infinity,
      child: LoadingButton(
        text: "Créer mon compte Lenra",
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              var authModel = context.read<AuthModel>();
              await authModel.register(this.email, this.password);
              Navigator.of(context).pushReplacementNamed(authModel.getRedirectionRouteAfterAuthentication());
            } catch (e) {}
          }
        },
        loading: isRegistering,
      ),
    );
  }

  Widget fields(BuildContext context) {
    return LenraColumn(
      separationFactor: 2,
      children: [
        //------Email------
        LenraTextFormField(
          label: 'Définissez un identifiant de connexion',
          hintText: 'email@email.com',
          onChanged: (String value) {
            email = value;
          },
          size: LenraComponentSize.Large,
          type: LenraTextFormFieldType.Email,
        ),
        //------Password------
        LenraTextFormField(
          label: 'Définissez un mot de passe',
          description: "8 caractères, 1 majuscule, 1 minuscule et 1 caractère spécial.",
          obscure: _hidePassword,
          onChanged: (String value) {
            password = value;
          },
          size: LenraComponentSize.Large,
          type: LenraTextFormFieldType.Password,
          onSuffixPressed: () {
            setState(() {
              this._hidePassword = !this._hidePassword;
            });
          },
        ),
      ],
    );
  }
}
