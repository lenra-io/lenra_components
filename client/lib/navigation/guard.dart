import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/models/user_application_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:provider/provider.dart';

class Guard {
  Future<bool> Function(BuildContext) isValid;
  Function(BuildContext) onInvalid;

  Guard({required this.isValid, required this.onInvalid});

  static const List<UserRole> _devOrMore = [UserRole.admin, UserRole.dev];

  static final Guard checkIsDev = Guard(isValid: _isDev, onInvalid: _becomeDev);
  static final Guard checkIsNotDev = Guard(isValid: _isNotDev, onInvalid: _toHome);
  static final Guard checkUnauthenticated = Guard(isValid: _isAuthenticated(false), onInvalid: _toHome);
  static final Guard checkAuthenticated = Guard(isValid: _isAuthenticated(true), onInvalid: _toLogin);
  static final Guard checkHaveApp = Guard(isValid: _haveApp(true), onInvalid: _toWelcome);
  static final Guard checkNotHaveApp = Guard(isValid: _haveApp(false), onInvalid: _toHome);

  static Future<bool> Function(BuildContext) _isAuthenticated(bool mustBeAuthenticated) {
    return (BuildContext context) async {
      AuthModel authModel = context.read<AuthModel>();
      if (!authModel.isAuthenticated() && authModel.refreshStatus.isNone()) {
        await authModel.refresh().catchError((e) {});
        /*if (authModel.refreshStatus.isNone())
          // Try to auth user with refresh token
          await authModel.refresh().catchError((e) => null);
        else if (authModel.refreshStatus.isFetching())
          // Wait current refresh response
          await authModel.refreshStatus.wait().catchError((e) => null);*/
      }
      // then check everything
      return authModel.isAuthenticated() == mustBeAuthenticated;
    };
  }

  static Future<bool> _isDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(_devOrMore);
  }

  static Future<bool> _isNotDev(BuildContext context) async {
    AuthModel authModel = context.read<AuthModel>();
    return authModel.isOneOfRole(UserRole.values.where((ur) => !_devOrMore.contains(ur)).toList());
  }

  static Future<bool> Function(BuildContext) _haveApp(bool mustHaveApp) {
    return (BuildContext context) async {
      try {
        List<AppResponse> userApps = await context.read<UserApplicationModel>().fetchUserApplications();
        return userApps.isNotEmpty == mustHaveApp;
      } catch (e) {
        return false;
      }
    };
  }

  static void _toWelcome(context) {
    Navigator.of(context).pushNamed(LenraNavigator.WELCOME);
  }

  static void _toLogin(BuildContext context) {
    context.read<AuthModel>().redirectToRoute = LenraNavigator.currentRoute;
    Navigator.of(context).pushReplacementNamed(LenraNavigator.LOGIN_ROUTE);
  }

  static void _becomeDev(context) {
    Navigator.of(context).pushReplacementNamed(LenraNavigator.VALIDATION_DEV_ROUTE);
  }

  static void _toHome(context) {
    Navigator.of(context).pushReplacementNamed(LenraNavigator.HOME_ROUTE);
  }
}
