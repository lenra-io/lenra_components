import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/api/response_models/apps_response.dart';

void main() {
  test('from json', () {
    Map<String, dynamic> json = {
      "apps": [
        {"name": "counter-new"},
        {"name": "helloworld"}
      ]
    };
    AppsResponse appsResponse = AppsResponse.fromJson(json);
    expect(appsResponse.apps.length, 2);
    expect(appsResponse.apps[0].name, "counter-new");
    expect(appsResponse.apps[1].name, "helloworld");
    expect(appsResponse is ApiResponse, true);
  });
}
