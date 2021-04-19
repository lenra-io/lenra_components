import 'package:fr_lenra_client/api/request_models/api_request.dart';

class ChangeLostPasswordRequest extends ApiRequest {
  final String code;
  final String email;
  final String password;
  final String passwordConfirmation;

  ChangeLostPasswordRequest(this.code, this.email, this.password, this.passwordConfirmation);

  ChangeLostPasswordRequest.fromJson(Map<String, String> json)
      : code = json["code"],
        email = json["email"],
        password = json["password"],
        passwordConfirmation = json["passwordConfirmation"];

  Map<String, String> toJson() => {
        'code': code,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
