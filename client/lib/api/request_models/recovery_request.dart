import 'package:fr_lenra_client/api/request_models/api_request.dart';

class RecoveryRequest extends ApiRequest {
  final String email;

  RecoveryRequest(this.email);

  RecoveryRequest.fromJson(Map<String, String> json) : email = json["email"];

  Map<String, String> toJson() => {
        'email': email,
      };
}
