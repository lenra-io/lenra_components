import 'package:fr_lenra_client/api/response_models/api_response.dart';

class AppResponse extends ApiResponse {
  String name;

  AppResponse.fromJson(Map<String, dynamic> json) : name = json["name"];
}
