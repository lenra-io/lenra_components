import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Checker = Future<bool> Function(BuildContext);

class PageGuard {
  final Future<bool> Function(BuildContext) isAuthorized;
  final Function(BuildContext) ifUnauthorized;

  PageGuard({
    @required this.isAuthorized,
    @required this.ifUnauthorized,
  });

  Future<bool> check(BuildContext context) async {
    bool authorized = await this.isAuthorized(context);
    if (!authorized) ifUnauthorized(context);
    return authorized;
  }
}
