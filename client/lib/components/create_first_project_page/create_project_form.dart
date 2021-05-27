import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_text_form_field.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/service/application_model.dart';
import 'package:fr_lenra_client/service/application_service.dart';
import 'package:fr_lenra_client/utils/form_validators.dart';
import 'package:provider/provider.dart';

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
    ApplicationModel applicationModel = context.watch<ApplicationModel>();
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
                applicationModel
                    .createApp(this.projectName, this.gitRepository)
                    .then((_) => ApplicationService.instance.loadUserApplications(force: true))
                    .then((_) => Navigator.of(context).pushNamed(LenraNavigator.HOME_ROUTE));
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
