import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

class LenraAppDataProvider extends InheritedWidget {
  final AppResponse appInfo;

  LenraAppDataProvider({
    @required this.appInfo,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(LenraAppDataProvider oldWidget) {
    return false;
  }

  static LenraAppDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(
      aspect: LenraAppDataProvider,
    );
  }
}
