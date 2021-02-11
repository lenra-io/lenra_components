import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

class AppsResponse extends ApiResponse {
  List<AppResponse> apps;

  AppsResponse.fromJson(Map<String, dynamic> json)
      : apps = json["apps"].map<AppResponse>((e) => AppResponse.fromJson(e)).toList();
}
