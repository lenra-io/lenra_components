import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/build_response.dart';
import 'package:fr_lenra_client/components/page/backoffice_page.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    AppResponse selectedApp = AppResponse.fromJson({
      "id": 42,
      "name": "Mon Appli",
      "service_name": "my_app",
      "icon": 0xe952,
      "color": Colors.blue.value.toRadixString(16),
    });
    List<BuildResponse>? builds;

    return BackofficePage(
      selectedApp: selectedApp,
      title: Text("Settings"),
      /* TODO: change onPressed function */
      mainActionWidget: LenraButton(
        text: "Publish my application",
        disabled: builds?.any((build) => build.status == BuildStatus.pending) ?? true,
        onPressed: () {},
      ),
      child: Text(
        "Settings",
        style: theme.lenraTextThemeData.disabledBodyText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
