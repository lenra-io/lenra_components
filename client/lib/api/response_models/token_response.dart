import 'package:fr_lenra_client/api/response_models/api_response.dart';

class TokenResponse extends ApiResponse {
  String accessToken;

  TokenResponse.fromJson(Map<String, dynamic> json) : accessToken = json["access_token"];
}
