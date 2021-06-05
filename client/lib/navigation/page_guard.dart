import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fr_lenra_client/navigation/guard.dart';

class PageGuard extends StatefulWidget {
  final List<Guard> guards;
  final Widget child;

  PageGuard({@required this.guards, @required this.child});

  @override
  State<StatefulWidget> createState() {
    return _PageGuardState();
  }
}

class _PageGuardState extends State<PageGuard> {
  Completer<bool> completer;

  _PageGuardState();
  @override
  void initState() {
    super.initState();
    this.completer = Completer();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      this.checkAll(this.context);
    });
  }

  void checkAll(BuildContext context) async {
    for (Guard checker in this.widget.guards) {
      try {
        if (!await checker.isValid(context)) {
          this.completer.complete(false);
          checker.onInvalid(context);
          return;
        }
      } catch (e) {
        print("Page Checker returned an error : " + e.toString());
        this.completer.complete(false);
        checker.onInvalid(context);
        return;
      }
    }
    this.completer.complete(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: this.completer.future,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return this.widget.child;
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
