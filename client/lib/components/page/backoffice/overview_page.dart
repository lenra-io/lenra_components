import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/build_response.dart';
import 'package:fr_lenra_client/components/page/backoffice_page.dart';
import 'package:fr_lenra_client/components/stateful_wrapper.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_cell.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';
import 'package:fr_lenra_client/models/build_model.dart';
import 'package:fr_lenra_client/models/user_application_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    var applicationModel = context.watch<UserApplicationModel>();
    var buildModel = context.watch<BuildModel>();

    return StatefulWrapper(
      onInit: () async {
        await applicationModel.fetchUserApplications();
        await buildModel.fetchBuilds(applicationModel.selectedApp.id);
      },
      builder: (context) {
        var selectedApp = applicationModel.selectedApp;
        // A bit dirty
        if (applicationModel.selectedApp == null) return Center(child: CircularProgressIndicator());
        int appId = selectedApp.id;
        List<BuildResponse> builds =
            context.select<BuildModel, List<BuildResponse>>((model) => model.buildsForApp(appId));

        var hasPendingBuild =
            builds.any((build) => build.status == BuildStatus.pending) || buildModel.createBuildStatus.isFetching();

        var hasPublishedBuild = builds.any((build) => build.status == BuildStatus.success);

        return BackofficePage(
          selectedApp: applicationModel.selectedApp,
          title: Text("Overview"),
          mainActionWidget: LenraButton(
            text: "Publish my application",
            disabled: hasPendingBuild,
            onPressed: () => buildModel.createBuild(applicationModel.selectedApp.id),
          ),
          child: LenraColumn(
            separationFactor: 2,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LenraButton(
                    disabled: !hasPublishedBuild,
                    text: "See my application",
                    type: LenraComponentType.Secondary,
                    onPressed: () async {
                      final url = "${Config.instance.appBaseUrl}${selectedApp.serviceName}";
                      if (await canLaunch(url))
                        await launch(url);
                      else
                        // can't launch url, there is some error
                        throw "Could not launch $url";
                    },
                  ),
                ],
              ),
              Table(
                children: [
                  TableRow(children: [
                    LenraTableCell(
                      child: Text("Build number"),
                    ),
                    LenraTableCell(
                      child: Text("Date"),
                    ),
                    LenraTableCell(
                      child: Text("Build status"),
                    ),
                  ]),
                  if (builds.isNotEmpty) buildRow(context, builds.last),
                  if (builds.length >= 2 && builds.last.status == BuildStatus.pending)
                    buildRow(context, builds.reversed.elementAt(1)),
                ],
              ),
              if (builds.isEmpty)
                Text(
                  "Your application have not been built yet.\nClic “Publish my application” to create your first build.",
                  style: theme.lenraTextThemeData.disabledBodyText,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
      },
    );
  }

  Color colorFromStatus(BuildStatus status) {
    switch (status) {
      case BuildStatus.success:
        return LenraColorThemeData.LENRA_FUN_GREEN_PULSE;

      case BuildStatus.pending:
        return LenraColorThemeData.LENRA_FUN_YELLOW_PULSE;

      case BuildStatus.failure:
        return LenraColorThemeData.LENRA_FUN_RED_PULSE;

      default:
        return LenraColorThemeData.LENRA_FUN_RED_PULSE;
    }
  }

  String textFromStatus(BuildStatus status) {
    switch (status) {
      case BuildStatus.success:
        return "Published";

      case BuildStatus.pending:
        return "Building...";

      case BuildStatus.failure:
        return "Failure";

      default:
        return "Failure";
    }
  }

  TableRow buildRow(BuildContext context, BuildResponse buildResponse) {
    var theme = LenraTheme.of(context);
    return TableRow(children: [
      LenraTableCell(
        child: Text("#${buildResponse.buildNumber}"),
      ),
      LenraTableCell(
        child: Text(DateFormat.yMMMMd().add_jm().format(buildResponse.insertedAt)),
      ),
      LenraTableCell(
        child: LenraRow(
          children: [
            Icon(
              Icons.circle,
              color: colorFromStatus(buildResponse.status),
              size: theme.baseSize,
            ),
            Text(textFromStatus(buildResponse.status)),
          ],
        ),
      ),
    ]);
  }
}
