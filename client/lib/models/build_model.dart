import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/request_models/create_build_request.dart';
import 'package:fr_lenra_client/api/response_models/build_response.dart';
import 'package:fr_lenra_client/api/response_models/builds_response.dart';
import 'package:fr_lenra_client/api/response_models/create_build_response.dart';
import 'package:fr_lenra_client/models/status.dart';

class BuildModel extends ChangeNotifier {
  Status<BuildsResponse> fetchBuildsStatus = Status();
  Status<CreateBuildResponse> createBuildStatus = Status();

  Map<int, List<BuildResponse>> buildsByApp = {};

  List<BuildResponse> buildsForApp(int appId) {
    if (buildsByApp.containsKey(appId)) return buildsByApp[appId]!;
    return [];
  }

  Future<List<BuildResponse>> fetchBuilds(int appId) async {
    var res = await fetchBuildsStatus.handle(() => ApplicationApi.getBuilds(appId), notifyListeners);
    this.buildsByApp[appId] = res.builds;
    notifyListeners();
    return res.builds;
  }

  Future<BuildResponse> createBuild(int appId) async {
    var res =
        await createBuildStatus.handle(() => ApplicationApi.createBuild(appId, CreateBuildRequest()), notifyListeners);
    this.buildsForApp(appId).add(res.build);
    notifyListeners();
    return res.build;
  }
}
