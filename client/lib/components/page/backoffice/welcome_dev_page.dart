import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';

class WelcomeDevPage extends StatelessWidget {
  static const TITLE = 'Bienvenue sur la plateforme technique !';
  static const WELCOME_TEXT =
      'Vous faites désormais partie de nos premiers utilisateurs et nous vous en remerciont. Nous sommes au tout début du projet et donc beaucoup de nouvelles fonctionnalités vont s’implémenter au fur et à mesure, vous pouvez aussi rencontrez quelques bugs, n’hésitez pas à nous les partager avec vos remarques et idées pour améliorer notre produit !';
  static const BUTTON_TEXT = 'Continuer et créer mon premier projet';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: TITLE,
      message: WELCOME_TEXT,
      child: LenraButton(
        text: BUTTON_TEXT,
        onPressed: () => Navigator.of(context).pushReplacementNamed(LenraNavigator.FIRST_PROJECT),
      ),
    );
  }
}
