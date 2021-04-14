import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class LenraAppPageContainer extends StatelessWidget {
  final String appName;
  LenraAppPageContainer({this.appName});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppListModel>(
      converter: (store) => AppListModel(store),
      builder: (context, appListModel) {
        return LenraAppPage(appName: appName, appListModel: appListModel);
      },
    );
  }
}
