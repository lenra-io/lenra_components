import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/request_models/create_build_request.dart';
import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/api/response_models/build_response.dart';
import 'package:fr_lenra_client/api/response_models/builds_response.dart';
import 'package:fr_lenra_client/api/response_models/create_build_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';

class Status<T> {
  RequestStatus requestStatus;
  ApiErrors errors;
  T _cacheData;

  Future<T> handle(Future<T> future) async {
    try {
      this.requestStatus = RequestStatus.fetching;
      this._cacheData = await future;
      this.requestStatus = RequestStatus.done;
      return this._cacheData;
    } on ApiErrors catch (errors) {
      this.requestStatus = RequestStatus.error;
      this.errors = errors;
      return Future.error(errors);
    }
  }
}

class BuildModel extends ChangeNotifier {
  Status<BuildsResponse> fetchBuildsStatus = Status();
  Status<CreateBuildResponse> createBuildStatus = Status();

  Map<int, List<BuildResponse>> buildsByApp = {};

  List<BuildResponse> buildsForApp(int appId) {
    if (buildsByApp.containsKey(appId)) return buildsByApp[appId];
    return [];
  }

  Future<List<BuildResponse>> fetchBuilds(int appId) async {
    var res = await fetchBuildsStatus.handle(ApplicationApi.getBuilds(appId));
    this.buildsByApp[appId] = res.builds;
    notifyListeners();
    return res.builds;
  }

  Future<BuildResponse> createBuild(int appId) async {
    var res = await createBuildStatus.handle(ApplicationApi.createBuild(appId, CreateBuildRequest()));
    this.buildsForApp(appId).add(res.build);
    notifyListeners();
    return res.build;
  }
}
