import 'package:fr_lenra_client/api/request_models/api_request.dart';

class ValidateUserRequest extends ApiRequest {
  final String code;

  ValidateUserRequest(this.code);

  dynamic toJson() => {
        "code": code,
      };
}
