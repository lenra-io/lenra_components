import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

/// The [asyncMiddleware] is used to handle one or more [AsyncAction].
///
/// This middleware checks whether the [AsyncAction] is fetching, done or has an error, doing the correct action accordingly.
Future asyncMiddleware(
  Store<AppState> store,
  AsyncAction action,
  NextDispatcher next,
) async {
  action.status = RequestStatus.fetching;
  next(action);
  try {
    /// trying to execute the future
    dynamic data = await action.future();
    action.status = RequestStatus.done;
    action.data = data;
    next(action);
  } on ApiErrors catch (errors) {
    /// The future threw an error
    action.status = RequestStatus.error;
    action.errors = errors;
    next(action);
  }
}
