import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/request_models/activation_code_request.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';
import 'package:fr_lenra_client/api/response_models/auth_response.dart';

class ApplicationApi {
  static LenraApi lenraApi = LenraApi();

  static Future<AppsResponse> getApps() => lenraApi.get(
        "/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );

  static Future<AuthResponse> activationCode(ActivationCodeRequest body) => lenraApi.put(
        "/verify/dev",
        body: body,
        responseMapper: (json) => AuthResponse.fromJson(json),
      );
}
