import 'package:fr_lenra_client/api/request_models/api_request.dart';

class ValidateDevRequest extends ApiRequest {
  final String code;

  ValidateDevRequest(this.code);

  ValidateDevRequest.fromJson(Map<String, String> json) : code = json["code"];
  dynamic toJson() => {
        "code": code,
      };
}
