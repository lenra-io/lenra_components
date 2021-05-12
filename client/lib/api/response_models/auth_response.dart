import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';

class AuthResponse extends ApiResponse {
  String accessToken;
  User user;

  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json["access_token"],
        user = User.fromJson(json["user"]);
}
