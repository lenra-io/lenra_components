import 'package:flutter/cupertino.dart';
import 'package:fr_lenra_client/api/request_models/api_request.dart';

class CreateAppRequest extends ApiRequest {
  final String name;
  final String serviceName;
  final String repository;
  final Color color;
  final IconData icon;

  CreateAppRequest({
    required this.name,
    required this.repository,
    required this.color,
    required this.icon,
  }) : this.serviceName = name.toLowerCase().trim().replaceAll(' ', '-');

  Map<String, dynamic> toJson() => {
        'name': name,
        'service_name': serviceName,
        'repository': repository,
        'color': color.value.toRadixString(16),
        'icon': icon.codePoint,
      };
}
