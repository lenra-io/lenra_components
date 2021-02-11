import 'package:flutter/material.dart';
import 'package:fr_lenra_client/navigation_helper.dart';
import 'package:fr_lenra_client/redux/actions/show_error_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

/// This middleware handles errors
///
/// When the action [ShowErrorAction] is captured by this middleware, a snackbar containing the error's information is displayed to the client.
void errorMiddleware(
  Store<AppState> store,
  ShowErrorAction action,
  NextDispatcher next,
) {
  ScaffoldMessenger.of(navigatorKey.currentContext).showSnackBar(SnackBar(
    content: Text(action.errors.toString()),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  ));
}
