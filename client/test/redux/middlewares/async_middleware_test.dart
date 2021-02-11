import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/middlewares/async_middleware.dart';

import '../actions/fake_async_action.dart';
import '../fake_store.dart';

void main() {
  test('async middleware on success', () async {
    int nextCallCounter = 0;

    await asyncMiddleware(createFakeStore(), FakeAsyncAction(), (action) {
      nextCallCounter++;
      expect(action is AsyncAction, true);
      FakeAsyncAction asyncAction = action as FakeAsyncAction;
      if (nextCallCounter == 1) {
        expect(asyncAction.isFetching, true);
        expect(asyncAction.isDone, false);
        expect(asyncAction.isError, false);
      } else if (nextCallCounter == 2) {
        expect(asyncAction.isFetching, false);
        expect(asyncAction.isDone, true);
        expect(asyncAction.isError, false);
        expect(asyncAction.data.fake, "fakeData");
      }
    });

    expect(nextCallCounter, 2);
  });

  test('async middleware on failure', () async {
    int nextCallCounter = 0;

    await asyncMiddleware(createFakeStore(), FakeAsyncAction(failure: true), (action) {
      nextCallCounter++;
      expect(action is AsyncAction, true);
      FakeAsyncAction asyncAction = action as FakeAsyncAction;
      if (nextCallCounter == 1) {
        expect(asyncAction.isFetching, true);
        expect(asyncAction.isDone, false);
        expect(asyncAction.isError, false);
      } else if (nextCallCounter == 2) {
        expect(asyncAction.isFetching, false);
        expect(asyncAction.isDone, false);
        expect(asyncAction.isError, true);
        expect(asyncAction.errors, []);
      }
    });

    expect(nextCallCounter, 2);
  });
}
