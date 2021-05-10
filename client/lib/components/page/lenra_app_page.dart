import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/components/error_list.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_controller.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';

/// This page show will show the UI recieved from the server. (UIStream send UIComponents to LenraApp)

class LenraAppPage extends StatefulWidget {
  static const routeName = '/app/:appName';

  static String getRouteName(appName) {
    return '/app/' + appName;
  }

  final String appName;
  final AppListModel appListModel;

  LenraAppPage({Key key, this.appName, this.appListModel}) : super(key: key);

  @override
  _LenraAppPageState createState() => _LenraAppPageState();
}

class _LenraAppPageState extends State<LenraAppPage> {
  @override
  void initState() {
    widget.appListModel.fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appListModel.status.isFetching) {
      return CircularProgressIndicator();
    }

    if (widget.appListModel.status.hasError) {
      return ErrorList(widget.appListModel.errors);
    }
    AppResponse appInfo = widget.appListModel.getAppInfoByServiceName(widget.appName);
    if (appInfo == null) {
      return Text("Oups !  L'application est introuvable...");
    }

    return LenraUiController(widget.appName);
  }
}
