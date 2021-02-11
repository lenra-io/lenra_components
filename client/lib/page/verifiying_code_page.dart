import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/verify_code_page/verify_code_form_container.dart';

class VerifyingCodePage extends StatelessWidget {
  static const routeName = '/code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text("Code de vérification"),
              Container(
                child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Text(
                          "Merci de votre inscription, vous avez reçu un mail avec un code de validation."),
                      VerifyCodeFormContainer(),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
