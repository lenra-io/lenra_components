import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/api/response_models/build_response.dart';

class CreateBuildResponse extends ApiResponse {
  BuildResponse build;

  CreateBuildResponse.fromJson(Map<String, dynamic> data) : build = BuildResponse.fromJson(data["build"]);
}
