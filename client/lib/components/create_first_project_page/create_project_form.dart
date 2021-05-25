import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/request_models/create_app_request.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/redux/actions/create_application_action.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';

class CreateProjectForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateProjectFormState();
  }
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  final _formKey = GlobalKey<FormState>();

  String projectName;
  String gitRepository;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: LenraColumn(
        separationFactor: 4,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          this.fields(context),
          LenraButton(
            text: "Créer mon premier projet",
            onPressed: () {
              if (_formKey.currentState.validate()) {
                LenraStore.getStore().dispatch(
                  CreateApplicationAction(
                    CreateAppRequest(
                      color: LenraColorThemeData.LENRA_FUN_GREEN_BASE,
                      icon: Icons.apps,
                      name: this.projectName,
                      repository: this.gitRepository,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget fields(BuildContext context) {
    return LenraColumn(
      separationFactor: 2,
      children: [
        LenraTextFormField(
          validator: validator([
            checkLength(min: 2, max: 35),
          ]),
          description: 'Maximum 35 charactères',
          label: 'Nom de votre projet',
          onChanged: (newValue) {
            setState(() {
              this.projectName = newValue;
            });
          },
        ),
        LenraTextFormField(
          validator: validator([
            checkGitRepoFormat(),
          ]),
          description:
              'Pour l’instant, le dépot doit être en accès public et il doit s’agir de la branche principale (Master).',
          label: 'URL de votre dépot Git',
          hintText: 'https://mygit.io/my_profile/my_project.git',
          onChanged: (newValue) {
            setState(() {
              this.gitRepository = newValue;
            });
          },
        ),
      ],
    );
  }
}
