import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fr_lenra_client/api/response_models/user.dart';
import 'package:fr_lenra_client/components/stateful_wrapper.dart';
import 'package:fr_lenra_client/navigation/authorized_guard.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/models/user_app_list_model.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:fr_lenra_client/redux/store.dart';

class BackofficeGuard extends AuthorizedGuard {
  static const _devOrMore = [UserRole.admin, UserRole.dev];
  BackofficeGuard({
    @required Widget child,
    bool hasApplication = true,
  }) : super(
          child: AuthorizedGuard(
            roles: _devOrMore,
            ifUnauthorized: () {
              LenraStore.dispatch(PushRouteAction(LenraNavigator.VALIDATION_DEV_ROUTE));
            },
            child: _BackofficeAppLoader(
              hasApplication: hasApplication,
              child: child,
            ),
          ),
        );
}

class _BackofficeAppLoader extends StatelessWidget {
  final bool hasApplication;
  final Widget child;

  const _BackofficeAppLoader({Key key, this.hasApplication, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserAppListModel>(
      converter: (store) => UserAppListModel(store),
      builder: (context, userAppListModel) {
        return StatefulWrapper(onInit: () {
          if (userAppListModel.status.isNoneOrError) {
            userAppListModel.fetchData();
          }
        }, builder: (context) {
          debugPrint("_BackofficeAppLoaderState isDone: ${userAppListModel.status.isDone}");
          if (userAppListModel.status.isDone) {
            return PageGuard(
              isAuthorized: () => hasApplication == userAppListModel.data.isNotEmpty,
              ifUnauthorized: () {
                LenraStore.dispatch(
                    PushRouteAction(hasApplication ? LenraNavigator.WELCOME : LenraNavigator.HOME_ROUTE));
              },
              child: child,
            );
          }
          return Center(
              child: CircularProgressIndicator(
            semanticsLabel: "Loading your application list.",
          ));
        });
      },
    );
  }
}
