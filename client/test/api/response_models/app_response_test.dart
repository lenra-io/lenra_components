import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {"name": "myapp"};
    AppResponse appResponse = AppResponse.fromJson(json);
    expect(appResponse.name, "myapp");
    expect(appResponse is ApiResponse, true);
  });
}
