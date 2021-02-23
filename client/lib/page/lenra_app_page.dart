import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/apps/lenra_app_data_provider.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_event.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component_wrapper.dart';
import 'package:fr_lenra_client/redux/models/app_list_model.dart';
import 'package:fr_lenra_client/socket/ui_stream_controller.dart';

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
  UIStreamController uiStreamController;

  @override
  void initState() {
    widget.appListModel.fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this.uiStreamController.close();
  }

  Widget buildThemedApp(Widget app, AppResponse appInfo) {
    Widget scaffold = Scaffold(
        body: app,
        appBar: AppBar(
            actionsIconTheme: IconThemeData(),
            title: Text(
              appInfo.name,
              style: TextStyle(color: appInfo.color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
            ),
            centerTitle: true));

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: appInfo.color,
        accentColor: appInfo.color,
        buttonColor: appInfo.color,
      ),
      child: scaffold,
    );
  }

  Widget buildCenteredInfo(Widget child) {
    return Scaffold(body: Center(child: child));
  }

  Widget buildCenteredError(String error) {
    return Scaffold(body: Center(child: Text(error)));
  }

  Widget buildWaitingOrErrorCase(ConnectionState connectionState) {
    switch (connectionState) {
      case ConnectionState.none:
        return this.buildCenteredError('No connexion !');
      case ConnectionState.waiting:
        return this.buildCenteredInfo(CircularProgressIndicator());
      case ConnectionState.active:
        return this.buildCenteredInfo(CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.amberAccent),
        ));
      case ConnectionState.done:
        return this.buildCenteredError('Nothing !');
      default:
        return this.buildCenteredError('Unknown state');
    }
  }

  StreamBuilder<LenraComponentWrapper> getStreamBuilder(Stream<LenraComponentWrapper> stream, AppResponse appInfo) {
    return StreamBuilder<LenraComponentWrapper>(
      stream: stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<LenraComponentWrapper> snapshot,
      ) {
        if (snapshot.hasData) {
          return this.buildThemedApp(snapshot.data, appInfo);
        } else {
          return this.buildWaitingOrErrorCase(snapshot.connectionState);
        }
      },
    );
  }

  bool handleNotifications(UIStreamController uiStreamController, LenraEvent notification) {
    if (notification.code != null) {
      uiStreamController.send(notification.toMap());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appListModel.status.isFetching) {
      return CircularProgressIndicator();
    }

    AppResponse appInfo = widget.appListModel.getAppInfoByName(widget.appName);
    if (appInfo == null) {
      return Text("Oups !  L'application est introuvable...");
    }

    this.uiStreamController = UIStreamController(widget.appName);
    return LenraAppDataProvider(
      uiStreamController: uiStreamController,
      appInfo: appInfo,
      child: NotificationListener<LenraEvent>(
        onNotification: (LenraEvent event) => this.handleNotifications(uiStreamController, event),
        child: this.getStreamBuilder(
          uiStreamController.uiStream,
          appInfo,
        ),
      ),
    );
  }
}
