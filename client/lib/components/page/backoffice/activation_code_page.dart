import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:provider/provider.dart';
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
    ApiErrors validateDevErrors = context.select<AuthModel, ApiErrors>((m) => m.validateDevStatus.errors);
    bool hasError = context.select<AuthModel, bool>((m) => m.validateDevStatus.hasError());
    bool isLoading = context.select<AuthModel, bool>((m) => m.validateDevStatus.isFetching());

    return SimplePage(
      title: "Merci pour votre inscription",
      message:
          "Lenra est encore à ses débuts et nous restreignons actuellement les créateurs d’applications, pour accéder à la plateforme developpeur, vous devez avoir un code d’accès.",
      child: LenraColumn(
        separationFactor: 4,
        children: [
          LenraColumn(
            separationFactor: 2,
            children: [
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
                  LenraButton(
                    text: "Confirmer le code",
                    disabled: isLoading,
                    onPressed: () async {
                      try {
                        await context.read<AuthModel>().validateDev(code);
                        Navigator.of(context).pushReplacementNamed(LenraNavigator.WELCOME);
                      } catch (e) {}
                    },
                  ),
                ],
              ),
              if (hasError) ErrorList(validateDevErrors),
            ],
          ),
          LenraButton(
            text: "Je n’ai pas encore de code, je retourne sur la page principale",
            type: LenraComponentType.Tertiary,
            onPressed: () async {
              const url = "https://www.lenra.io";
              if (await canLaunch(url))
                await launch(url);
              else
                // can't launch url, there is some error
                throw "Could not launch $url";
            },
          ),
        ],
      ),
    );
  }
}
