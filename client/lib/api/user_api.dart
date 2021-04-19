import 'package:fr_lenra_client/api/lenra_http_client.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/api/response_models/empty_response.dart';
import 'package:fr_lenra_client/api/response_models/token_response.dart';

class UserApi {
  static LenraAuth lenraAuth = LenraAuth();
  static LenraApi lenraApi = LenraApi();

  static Future<TokenResponse> register(RegisterRequest body) => lenraAuth.post(
        "/register",
        body: body,
        responseMapper: (json) => TokenResponse.fromJson(json),
      );

  static Future<TokenResponse> login(LoginRequest body) => lenraAuth.post(
        "/login",
        body: body,
        responseMapper: (json) => TokenResponse.fromJson(json),
      );

  static Future<TokenResponse> verifyCode(VerifyCodeRequest body) => lenraAuth.post(
        "/verify",
        body: body,
        responseMapper: (json) => TokenResponse.fromJson(json),
      );

  static Future<TokenResponse> refresh() => lenraAuth.post(
        "/refresh",
        responseMapper: (json) => TokenResponse.fromJson(json),
      );

  static Future<EmptyResponse> logout() => lenraAuth.post(
        "/logout",
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );
  static Future<EmptyResponse> changePassword(ChangePasswordRequest body) => lenraApi.put(
        "/password",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> changeLostPassword(ChangeLostPasswordRequest body) => lenraAuth.put(
        "/password/lost",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );

  static Future<EmptyResponse> emailVerificationLostPassword(RecoveryRequest body) => lenraAuth.post(
        "/password/lost",
        body: body,
        responseMapper: (json) => EmptyResponse.fromJson(json),
      );
}
