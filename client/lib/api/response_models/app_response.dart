import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/utils/color_parser.dart';

class AppResponse extends ApiResponse {
  String name;
  String serviceName;
  IconData icon;
  Color color;

  AppResponse.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        serviceName = json["service_name"],
        icon = IconData(json["icon"], fontFamily: 'MaterialIcons'),
        color = json["color"].toString().parseColor();
}
