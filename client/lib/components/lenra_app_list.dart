import 'package:flutter/material.dart';
import 'package:fr_lenra_client/services/application_service.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';
import 'package:fr_lenra_client/page/app_page.dart';
import 'package:fr_lenra_client/components/lenra_app_button.dart';

class AppList extends StatefulWidget {
  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  Future<List<LenraApplicationInfo>> futureApps =
      ApplicationService.getAppList();
  List<Widget> buttonList = [];

  Widget build(BuildContext context) {
    return FutureBuilder<List<LenraApplicationInfo>>(
        future: futureApps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.forEach((element) {
              buttonList.add(AppButton(
                appInfo: element,
                onPressed: () {
                  Navigator.pushNamed(
                      this.context, LenraAppPage.getRouteName(element.name));
                },
              ));
            });
            return Wrap(
              children: buttonList,
            );
          } else if (snapshot.hasError) {
            throw snapshot.error;
            // return Text("Erreur app list : ${snapshot.error}");
          }

          //retour par default
          return CircularProgressIndicator();
        });
  }
}
