import 'package:flutter/material.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';
import 'package:fr_lenra_client/socket/ui_stream_controller.dart';

class LenraAppDataProvider extends InheritedWidget {
  final UIStreamController uiStreamController;
  final LenraApplicationInfo appInfo;

  LenraAppDataProvider({
    @required this.uiStreamController,
    @required this.appInfo,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(LenraAppDataProvider oldWidget) {
    return this.uiStreamController != oldWidget.uiStreamController ||
        this.appInfo != oldWidget.appInfo;
  }

  static LenraAppDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(
      aspect: LenraAppDataProvider,
    );
  }
}
