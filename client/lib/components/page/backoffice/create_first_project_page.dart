import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/components/create_first_project_page/create_project_form.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';

class CreateFirstProjectPage extends StatelessWidget {
  static const String TITLE_TEXT = 'Créez votre premier projet';
  static const String MESSAGE_TEXT =
      'Définissez un nom à votre premier projet et indiquez nous également l’url de votre dépot Gitlab / Github pour pouvoir créer votre première application.';
  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: TITLE_TEXT,
      message: MESSAGE_TEXT,
      child: LenraColumn(
        children: [
          CreateProjectForm(),
        ],
      ),
    );
  }
}
