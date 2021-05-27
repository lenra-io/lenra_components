import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/api/request_models/create_app_request.dart';
import 'package:fr_lenra_client/api/request_models/create_build_request.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';
import 'package:fr_lenra_client/api/response_models/builds_response.dart';
import 'package:fr_lenra_client/api/response_models/create_app_response.dart';
import 'package:fr_lenra_client/api/response_models/create_build_response.dart';

class ApplicationApi {
  static LenraApi lenraApi = LenraApi();

  static Future<AppsResponse> getApps() => lenraApi.get(
        "/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );

  static Future<CreateAppResponse> createApp(CreateAppRequest body) => lenraApi.post(
        "/apps",
        body: body,
        responseMapper: (json) => CreateAppResponse.fromJson(json),
      );

  static Future<BuildsResponse> getBuilds(int appId) => lenraApi.get(
        "/apps/$appId/builds",
        responseMapper: (json) => BuildsResponse.fromJson(json),
      );

  static Future<CreateBuildResponse> createBuild(int appId, CreateBuildRequest body) => lenraApi.post(
        "/apps/$appId/builds",
        body: body,
        responseMapper: (json) => CreateBuildResponse.fromJson(json),
      );

  static Future<AppsResponse> getUserApps() => lenraApi.get(
        "/me/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );

  static Future<AuthResponse> activationCode(ActivationCodeRequest body) => lenraApi.put(
        "/verify/dev",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );
}
