import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/utils/color_parser.dart';

class AppResponse extends ApiResponse {
  int id;
  String name;
  String serviceName;
  IconData icon;
  Color color;
  bool public;

  AppResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        serviceName = json["service_name"],
        icon = IconData(json["icon"], fontFamily: 'MaterialIcons'),
        color = json["color"].toString().parseColor(),
        public = false;
}
