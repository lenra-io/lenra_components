import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/loading_button.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(hintText: 'Entrez votre email', labelText: 'Email :'),
            onChanged: (String value) {
              setState(() {
                this.email = value;
              });
            },
            validator: validator([
              checkNotEmpty(),
              checkLength(min: 2, max: 64),
              checkEmailFormat(),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LoadingButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this.recoveryModel.fetchData(body: RecoveryRequest(this.email));
                }
              },
              text: 'Envoyer',
              loading: this.recoveryModel.status.isFetching,
            ),
          ),
          ErrorList(this.recoveryModel.errors),
        ],
      ),
    );
  }
}
