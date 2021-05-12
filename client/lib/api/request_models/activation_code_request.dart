import 'package:fr_lenra_client/api/request_models/api_request.dart';

class ActivationCodeRequest extends ApiRequest {
  final String code;

  ActivationCodeRequest(this.code);

  ActivationCodeRequest.fromJson(Map<String, String> json) : code = json["code"];
  dynamic toJson() => {
        "code": code,
      };
}
