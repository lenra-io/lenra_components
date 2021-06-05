import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/request_models/create_app_request.dart';
import 'package:fr_lenra_client/api/request_models/create_build_request.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/api/response_models/builds_response.dart';
import 'package:fr_lenra_client/api/response_models/create_app_response.dart';
import 'package:fr_lenra_client/api/response_models/create_build_response.dart';

class ApplicationApi {
  static Future<AppsResponse> getApps() => LenraApi.instance.get(
        "/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );

  static Future<CreateAppResponse> createApp(CreateAppRequest body) => LenraApi.instance.post(
        "/apps",
        body: body,
        responseMapper: (json) => CreateAppResponse.fromJson(json),
      );

  static Future<BuildsResponse> getBuilds(int appId) => LenraApi.instance.get(
        "/apps/$appId/builds",
        responseMapper: (json) => BuildsResponse.fromJson(json),
      );

  static Future<CreateBuildResponse> createBuild(int appId, CreateBuildRequest body) => LenraApi.instance.post(
        "/apps/$appId/builds",
        body: body,
        responseMapper: (json) => CreateBuildResponse.fromJson(json),
      );

  static Future<AppsResponse> getUserApps() => LenraApi.instance.get(
        "/me/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );
}
