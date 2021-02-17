import 'dart:convert';

import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/config/connexion_utils_stub.dart'
    if (dart.library.io) 'package:fr_lenra_client/config/connexion_utils_io.dart'
    if (dart.library.js) 'package:fr_lenra_client/config/connexion_utils_web.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:http/http.dart' as http;

typedef T ResponseMapper<T>(dynamic json);

abstract class LenraBaseHttpClient {
  final http.Client client;

  LenraBaseHttpClient() : this.client = createHttpClient();

  String get _apiUrl;
  Map<String, String> get _headers;

  String encodeBody(dynamic body) {
    return body != null ? json.encode(body) : null;
  }

  Future<T> _handleResponse<T>(Future<http.Response> futureReponse, {T Function(dynamic) responseMapper}) async {
    responseMapper = responseMapper ?? (e) => e;
    print("API Call");
    http.Response response = await futureReponse;
    Map<String, dynamic> body = json.decode(response.body);
    print(body);
    if (body["success"]) {
      print("API call succeed !");
      return responseMapper(body["data"]);
    } else {
      print("API call returned an error.");
      throw ApiErrors.fromJson(body["errors"]);
    }
  }

  Future<T> get<T>(String url, {ResponseMapper<T> responseMapper}) {
    Future<http.Response> response = client.get(
      "$_apiUrl$url",
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> post<T>(String url, {ResponseMapper<T> responseMapper, dynamic body}) {
    print("API Call POST on $_apiUrl$url");
    Future<http.Response> response = client.post(
      "$_apiUrl$url",
      body: encodeBody(body),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> put<T>(String url, {ResponseMapper<T> responseMapper, dynamic body}) {
    Future<http.Response> response = client.put(
      "$_apiUrl$url",
      body: encodeBody(body),
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }

  Future<T> delete<T>(String url, {ResponseMapper<T> responseMapper, dynamic body}) {
    Future<http.Response> response = client.delete(
      "$_apiUrl$url",
      headers: _headers,
    );
    return _handleResponse(response, responseMapper: responseMapper);
  }
}

class LenraApi extends LenraBaseHttpClient {
  @override
  String get _apiUrl {
    return "${Config.instance.httpEndpoint}/api";
  }

  @override
  Map<String, String> get _headers {
    String token = LenraStore.getStore().state.authState.tokenResponse?.accessToken;
    return {"Content-Type": "application/json", "Authorization": "Bearer $token"};
  }
}

class LenraAuth extends LenraBaseHttpClient {
  @override
  String get _apiUrl {
    return "${Config.instance.httpEndpoint}/auth";
  }

  @override
  Map<String, String> get _headers {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if (Config.instance.basicAuth.isNotEmpty) {
      headers["Authorization"] = "Basic ${Config.instance.basicAuth}";
    }

    return headers;
  }
}
