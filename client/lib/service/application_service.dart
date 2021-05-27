import 'package:fr_lenra_client/api/application_api.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

class ApplicationService {
  static final ApplicationService instance = ApplicationService._();
  ApplicationService._();

  _DataProvider<List<AppResponse>> userApplicationLoader;

  Future<List<AppResponse>> loadUserApplications({bool force = false}) {
    if (force || userApplicationLoader == null) {
      this.userApplicationLoader = _DataProvider(
        ApplicationApi.getUserApps().then((appsResponse) => appsResponse.apps),
      );
    }
    return userApplicationLoader.getFuture();
  }
}

class _DataProvider<T> {
  Future<T> _future;
  T _data;
  bool _loaded = false;
  var _error;

  _DataProvider(Future<T> future) {
    _future = future.then((value) {
      _data = value;
      _loaded = true;
      return value;
    }).catchError((error) {
      _loaded = true;
      this._error = error;
    });
  }

  Future<T> getFuture() {
    if (_loaded) {
      if (_error != null) return Future.error(_error);
      return Future.value(_data);
    }
    return _future;
  }
}
