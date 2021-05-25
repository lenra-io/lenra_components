import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/components/stateful_wrapper.dart';
import 'package:fr_lenra_client/components/store_page/app_list.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';

class AppListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppListModel>(
      converter: (store) => AppListModel(store),
      builder: (context, appListModel) {
        return StatefulWrapper(
          builder: (context) => AppList(appListModel: appListModel),
          onInit: appListModel.fetchData,
        );
      },
    );
  }
}
