import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

Store<AppState> createFakeStore({fakeReducer, initialState}) {
  return Store<AppState>(
    fakeReducer ?? (AppState state, action) => state,
    initialState: initialState ?? AppState(),
  );
}
