import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/models/status.dart';

class StoreModel extends ChangeNotifier {
  Status<AppsResponse> fetchApplicationsStatus;
  List<AppResponse> applications;

  Future<List<AppResponse>> fetchApplications() async {
    var res = await fetchApplicationsStatus.handle(ApplicationApi.getApps, notifyListeners);
    this.applications = res.apps;
    notifyListeners();
    return res.apps;
  }
}
