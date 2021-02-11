import 'package:fr_lenra_client/api/request_models/api_request.dart';

class VerifyCodeRequest extends ApiRequest {
  final String code;

  VerifyCodeRequest(this.code);

  VerifyCodeRequest.fromJson(Map<String, String> json) : code = json["code"];
  dynamic toJson() => {
        "code": code,
      };
}
