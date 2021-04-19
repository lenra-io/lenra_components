import 'package:fr_lenra_client/api/request_models/api_request.dart';

class ChangePasswordRequest extends ApiRequest {
  final String oldPassword;
  final String password;
  final String passwordConfirmation;

  ChangePasswordRequest(this.oldPassword, this.password, this.passwordConfirmation);

  ChangePasswordRequest.fromJson(Map<String, String> json)
      : oldPassword = json["oldPassword"],
        password = json["password"],
        passwordConfirmation = json["passwordConfirmation"];

  Map<String, String> toJson() => {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
