import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/store_page/app_button.dart';
import 'package:fr_lenra_client/page/lenra_app_page.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';

class AppList extends StatelessWidget {
  final AppListModel appListModel;

  AppList({this.appListModel});

  Widget build(BuildContext context) {
    if (appListModel.status.hasError) {
      // TODO : create PrintErrors component
      return Text("Oups, il y a des erreurs...");
    }

    if (appListModel.status.isDone) {
      List<Widget> buttonList = [];
      appListModel.convertAppListToAppsInfo().forEach((appInfo) {
        buttonList.add(AppButton(
          appInfo: appInfo,
          onPressed: () {
            Navigator.of(context).pushNamed(LenraAppPage.getRouteName(appInfo.name));
          },
        ));
      });

      return Wrap(
        children: buttonList,
      );
    }

    return CircularProgressIndicator();
  }
}
