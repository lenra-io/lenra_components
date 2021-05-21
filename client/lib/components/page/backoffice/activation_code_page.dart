import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/redux/models/activation_code_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivationCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivationCodePageState();
  }
}

class _ActivationCodePageState extends State<ActivationCodePage> {
  String code;

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: "Merci pour votre inscription",
      message:
          "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès.",
      child: LenraColumn(
        separationFactor: 4,
        children: [
          // Code form
          LenraRow(
            separationFactor: 2,
            fillParent: true,
            children: [
              Expanded(
                child: LenraTextField(
                  hintText: "Code d'accès",
                  onChanged: (String value) {
                    code = value;
                  },
                ),
              ),
              StoreConnector<AppState, ActivationCodeModel>(
                converter: (store) => ActivationCodeModel(store),
                builder: (context, activationCodeModel) {
                  return LenraButton(
                    text: "Confirmer le code",
                    disabled: activationCodeModel.status.isFetching,
                    onPressed: () {
                      activationCodeModel.fetchData(body: ActivationCodeRequest(code));
                    },
                  );
                },
              )
            ],
          ),
          LenraButton(
            text: "Je n’ai pas encore de code, je retourne sur la page principale",
            type: LenraButtonType.Tertiary,
            onPressed: () async {
              const url = "https://www.lenra.io";
              if (await canLaunch(url))
                await launch(url);
              else
                // can't launch url, there is some error
                throw "Could not launch $url";
              // Navigator.pushNamed(context, '/recovery');
            },
          ),
        ],
      ),
    );
  }
}
