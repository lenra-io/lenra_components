import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:provider/provider.dart';

class RecoveryForm extends StatefulWidget {
  @override
  _RecoveryFormState createState() {
    return _RecoveryFormState();
  }
}

class _RecoveryFormState extends State<RecoveryForm> {
  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;
    ApiErrors askCodeLostPasswordErrors =
        context.select<AuthModel, ApiErrors>((m) => m.askCodeLostPasswordStatus.errors);
    return Form(
      key: _formKey,
      child: LenraColumn(
        separationFactor: 3,
        children: <Widget>[
          Text(
            "Confirmez-nous votre email et on s'occupe de ça.",
            textAlign: TextAlign.center,
            style: finalLenraTextThemeData.disabledBodyText,
          ),
          LenraTextFormField(
            hintText: "email@email.com",
            onChanged: (String value) {
              this.email = value;
            },
            type: LenraTextFormFieldType.Email,
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              text: "Je ré-initialise mon mot de passe",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<AuthModel>().askCodeLostPassword(this.email);
                }
              },
            ),
          ),
          ErrorList(askCodeLostPasswordErrors),
        ],
      ),
    );
  }
}
