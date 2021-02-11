import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';

class ApplicationApi {
  static LenraApi lenraApi = LenraApi();

  static Future<AppsResponse> getApps() => lenraApi.get(
        "/apps",
        responseMapper: (json) => AppsResponse.fromJson(json),
      );
}
