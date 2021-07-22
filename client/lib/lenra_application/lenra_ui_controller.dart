import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_builder.dart';
import 'package:fr_lenra_client/lenra_application/ui_patch.dart';
import 'package:fr_lenra_client/models/socket_model.dart';
import 'package:fr_lenra_client/models/user_application_model.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';
import 'package:provider/provider.dart';

class LenraUiController extends StatefulWidget {
  final String? appName;

  LenraUiController(this.appName);

  @override
  State<StatefulWidget> createState() {
    return _LenraUiControllerState();
  }
}

class _LenraUiControllerState extends State<LenraUiController> {
  late LenraChannel channel;
  StreamController<Map<String, dynamic>> uiStream;
  StreamController<Iterable<UiPatchEvent>> patchUiStream;
  bool error = false;
  bool isInitialized = false;

  _LenraUiControllerState()
      : this.uiStream = StreamController(),
        this.patchUiStream = StreamController();

  @override
  void initState() {
    debugPrint("initState ${widget.appName}");
    super.initState();
    this.channel = this.context.read<SocketModel>().channel("app", {"app": widget.appName});
    context.read<UserApplicationModel>().currentApp = widget.appName;

    this.channel.onUi((Map<dynamic, dynamic>? ui) {
      if (ui == null) return;
      this.uiStream.add(ui as Map<String, dynamic>);
      if (!this.isInitialized) {
        setState(() {
          this.isInitialized = true;
        });
      }
    });

    this.channel.onPatchUi((Map<dynamic, dynamic>? json) {
      List<dynamic> patches = json?["patch"] as List;
      Iterable<UiPatchEvent> parsedPatches = patches.map((patch) {
        return UiPatchEvent.fromPatch(patch as Map<String, dynamic>);
      }).toList();
      this.patchUiStream.add(parsedPatches);
    });

    channel.onError(() {
      setState(() {
        error = true;
      });
    });
  }

  @override
  void dispose() {
    debugPrint("dispose ${widget.appName}");
    this.channel.close();
    this.uiStream.close();
    this.patchUiStream.close();
    super.dispose();
  }

  bool handleNotifications(LenraEvent notification) {
    this.channel.send('run', notification.toMap());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (error)
      return Scaffold(
        body: Center(
          child: Text("No application"),
        ),
      );
    if (!this.isInitialized)
      return Center(
        child: CircularProgressIndicator(),
      );
    return NotificationListener<LenraEvent>(
      onNotification: (LenraEvent event) => this.handleNotifications(event),
      child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
    );
  }
}
