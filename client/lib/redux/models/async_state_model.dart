import 'package:fr_lenra_client/api/response_models/api_response.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/models/async_status_model.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';

abstract class AsyncStateModel<T extends ApiResponse, A extends AsyncAction> extends AsyncStatusModel<A> {
  const AsyncStateModel(store) : super(store);

  // Can be override if the data is not in the default location.
  T get data {
    return (status as AsyncState<T>).data;
  }
}
