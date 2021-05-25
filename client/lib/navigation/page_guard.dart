import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef bool Checker();

class PageGuard extends StatelessWidget {
  final Widget child;
  final Checker isAuthorized;
  final Function ifUnauthorized;

  PageGuard({
    @required this.child,
    @required this.isAuthorized,
    @required this.ifUnauthorized,
  });

  @override
  Widget build(BuildContext context) {
    if (this.isAuthorized()) return this.child;

    SchedulerBinding.instance.scheduleFrameCallback((_) {
      ifUnauthorized();
    });
    return Center(child: CircularProgressIndicator());
  }
}
