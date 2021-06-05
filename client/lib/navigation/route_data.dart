import 'package:flutter/widgets.dart';

class RouteData {
  Map<String, String> params = Map();
  Widget Function(Map<String, String>) builder;

  final defaultParams = Map();

  void addParam(name, value) {
    params[name] = value;
  }

  RouteData(this.builder, this.params);
}
