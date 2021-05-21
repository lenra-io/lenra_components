import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PageGuard extends StatelessWidget {
  final Widget child;

  PageGuard({@required this.child});

  @override
  Widget build(BuildContext context) {
    if (this.isAuthorized()) return this.child;
    ifUnauthorized();
    return Center(child: CircularProgressIndicator());
  }

  void ifUnauthorized();
  bool isAuthorized();
}
