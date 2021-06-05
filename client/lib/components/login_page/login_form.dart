import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/loading_button.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiErrors loginErrors = context.select<AuthModel, ApiErrors>((m) => m.loginStatus.errors);

    return Form(
      key: _formKey,
      child: LenraColumn(
        separationFactor: 2,
        children: <Widget>[
          login(context),
          Image.asset(
            'assets/images/colored-line.png',
          ),
          Text(
            "Vous n'avez pas encore de compte Lenra ?",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              type: LenraComponentType.Secondary,
              text: "Créer un compte",
              onPressed: () {
                Navigator.pushReplacementNamed(context, LenraNavigator.REGISTER_ROUTE);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                text: "J'ai oublié mon mot de passe",
                style: finalLenraTextThemeData.blueBodyText,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(context, LenraNavigator.LOST_PASSWORD_ROUTE);
                  },
              ),
            ),
          ),
          ErrorList(loginErrors),
        ],
      ),
    );
  }

  Widget login(BuildContext context) {
    bool isLogging = context.select<AuthModel, bool>((m) => m.loginStatus.isFetching());
    return LenraColumn(
      separationFactor: 2,
      children: [
        //------Email------
        LenraTextFormField(
          label: 'Identifiant',
          hintText: 'Email',
          onChanged: (String value) {
            email = value;
          },
          size: LenraComponentSize.Large,
          validator: validator([
            checkNotEmpty(),
            checkLength(min: 2, max: 64),
            checkEmailFormat(),
          ]),
        ),
        //------Password------
        LenraTextFormField(
          label: 'Mot de passe',
          obscure: _hidePassword,
          onChanged: (String value) {
            password = value;
          },
          size: LenraComponentSize.Large,
          validator: validator([
            checkNotEmpty(),
            checkLength(min: 8, max: 64),
          ]),
          onSuffixPressed: () {
            setState(() {
              this._hidePassword = !this._hidePassword;
            });
          },
        ),
        SizedBox(
          width: double.infinity,
          child: LoadingButton(
            text: "Se connecter",
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  var authModel = context.read<AuthModel>();
                  await authModel.login(this.email, this.password);
                  Navigator.of(context).pushReplacementNamed(authModel.getRedirectionRouteAfterAuthentication());
                } catch (e) {}
              }
            },
            loading: isLogging,
          ),
        ),
      ],
    );
  }
}
