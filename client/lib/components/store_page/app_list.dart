import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page.dart';
import 'package:fr_lenra_client/components/store_page/app_button.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';

class AppList extends StatelessWidget {
  final AppListModel appListModel;

  AppList({this.appListModel});

  Widget build(BuildContext context) {
    if (appListModel.status.hasError) {
      return ErrorList(appListModel.errors);
    }

    if (appListModel.status.isDone) {
      return Wrap(
        children: appListModel.data.apps.map((appInfo) {
          return AppButton(
            appInfo: appInfo,
            onPressed: () {
              Navigator.of(context).pushNamed(LenraAppPage.getRouteName(appInfo.serviceName));
            },
          );
        }).toList(),
      );
    }

    return CircularProgressIndicator();
  }
}
