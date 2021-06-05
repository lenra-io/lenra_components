import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/components/store_page/app_button.dart';
import 'package:fr_lenra_client/models/store_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:provider/provider.dart';

class AppList extends StatelessWidget {
  Widget build(BuildContext context) {
    StoreModel storeModel = context.watch<StoreModel>();
    if (storeModel.fetchApplicationsStatus.hasError()) {
      return ErrorList(storeModel.fetchApplicationsStatus.errors);
    }

    if (storeModel.fetchApplicationsStatus.isDone()) {
      return Wrap(
        children: storeModel.applications.map((appInfo) {
          return AppButton(
            appInfo: appInfo,
            onPressed: () {
              Navigator.of(context).pushNamed(LenraNavigator.buildAppRoute(appInfo.serviceName));
            },
          );
        }).toList(),
      );
    }

    return CircularProgressIndicator();
  }
}
