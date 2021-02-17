import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/show_error_action.dart';
import 'package:fr_lenra_client/redux/middlewares/async_middleware.dart';
import 'package:fr_lenra_client/redux/middlewares/auth_middleware.dart';
import 'package:fr_lenra_client/redux/middlewares/error_middleware.dart';
import 'package:fr_lenra_client/redux/middlewares/redirect_middleware.dart';
import 'package:fr_lenra_client/redux/middlewares/refresh_token_middleware.dart';
import 'package:fr_lenra_client/redux/middlewares/socket_middleware.dart';
import 'package:fr_lenra_client/redux/reducers/app_reducer.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

class LenraStore {
  static var _store;

  static Future<Store<AppState>> loadStore() async {
    if (_store == null) {
      if (kReleaseMode) {
        _store = await LenraStore._createStore();
      } else {
        _store = await LenraStore._createDevStore();
      }
    }
    return _store;
  }

  static Store<AppState> getStore() {
    return _store;
  }

  static List<dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))> createMiddlewares() {
    return [
      TypedMiddleware<AppState, AsyncAction>(asyncMiddleware),
      TypedMiddleware<AppState, Action>(socketMiddleware),
      TypedMiddleware<AppState, AsyncAction>(refreshTokenMiddleware),
      TypedMiddleware<AppState, AsyncAction>(authMiddleware),
      TypedMiddleware<AppState, PushRouteAction>(redirectMiddleware),
      TypedMiddleware<AppState, ShowErrorAction>(errorMiddleware),
    ];
  }

  static Future<Store<AppState>> _createStore() async {
    return Store<AppState>(
      appStateReducer,
      initialState: AppState(),
      middleware: LenraStore.createMiddlewares(),
    );
  }

  static Future<Store<AppState>> _createDevStore() async {
    ActionDecoder myDecoder = (dynamic payload) {
      final json = payload as Map<String, dynamic>;
      if (json['type'] == 'LoginFetching') {
        return LoginAction(LoginRequest(json['email'], json['password']));
      }
    };

    var remoteDevtools = RemoteDevToolsMiddleware('127.0.0.1:8000', actionDecoder: myDecoder);

    var middlewares = LenraStore.createMiddlewares();
    middlewares.add(remoteDevtools);
    var store = new DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState(),
      middleware: middlewares,
    );

    remoteDevtools.store = store;
    remoteDevtools.connect();
    return store;
  }
}
