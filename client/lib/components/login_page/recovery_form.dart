import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/redux/models/recovery_model.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

class RecoveryForm extends StatefulWidget {
  final RecoveryModel recoveryModel;

  RecoveryForm({this.recoveryModel});

  @override
  _RecoveryFormState createState() {
    return _RecoveryFormState(recoveryModel: this.recoveryModel);
  }
}

class _RecoveryFormState extends State<RecoveryForm> {
  final RecoveryModel recoveryModel;

  _RecoveryFormState({this.recoveryModel}) : super();

  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

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
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
              checkEmailFormat(),
            ]),
          ),
          SizedBox(
            width: double.infinity,
            child: LenraButton(
              text: "Je ré-initialise mon mot de passe",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this.recoveryModel.fetchData(body: RecoveryRequest(email));
                }
              },
            ),
          ),
          ErrorList(this.recoveryModel.errors),
        ],
      ),
    );
  }
}
