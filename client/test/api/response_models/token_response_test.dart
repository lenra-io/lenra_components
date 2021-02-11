import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/token_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"access_token": "myaccesstoken.truc.machin"};
    TokenResponse tokenResponse = TokenResponse.fromJson(json);
    expect(tokenResponse.accessToken, "myaccesstoken.truc.machin");
    expect(tokenResponse is TokenResponse, true);
  });
}
