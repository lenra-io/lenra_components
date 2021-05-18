import 'package:fr_lenra_client/api/request_models/api_request.dart';

class RegisterRequest extends ApiRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  RegisterRequest(this.email, this.password, {this.firstName, this.lastName});

  RegisterRequest.fromJson(Map<String, String> json)
      : email = json["email"],
        firstName = json["first_name"],
        lastName = json["last_name"],
        password = json["password"];

  Map<String, String> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      };
}
