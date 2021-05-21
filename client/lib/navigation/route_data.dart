import 'package:fr_lenra_client/navigation/custom_route_builder.dart';

class RouteData {
  Map<String, String> params = Map();
  CustomRouteBuilder builder;

  final defaultParams = Map();

  void addParam(name, value) {
    params[name] = value;
  }

  RouteData(this.builder);
}
