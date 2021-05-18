import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/api/request_models/change_lost_password_request.dart';
import 'package:fr_lenra_client/api/request_models/change_password_request.dart';
import 'package:fr_lenra_client/api/request_models/loginRequest.dart';
import 'package:fr_lenra_client/api/request_models/recovery_request.dart';
import 'package:fr_lenra_client/api/request_models/register_request.dart';
import 'package:fr_lenra_client/api/request_models/verify_code_request.dart';
import 'package:fr_lenra_client/components/page/change_lost_password_page.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/store_page.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';
import 'package:fr_lenra_client/redux/actions/async_action.dart';
import 'package:fr_lenra_client/redux/actions/change_lost_password_action.dart';
import 'package:fr_lenra_client/redux/actions/change_password_action.dart';
import 'package:fr_lenra_client/redux/actions/login_action.dart';
import 'package:fr_lenra_client/redux/actions/logout_action.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/actions/recovery_action.dart';
import 'package:fr_lenra_client/redux/actions/register_action.dart';
import 'package:fr_lenra_client/redux/actions/verify_code_action.dart';
import 'package:fr_lenra_client/redux/middlewares/auth_middleware.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockedStore extends Mock implements Store<AppState> {}

class MockedAction extends Mock implements Action {}

void main() {
  void checkNotCallingDispatch<A>(store, action) {
    authMiddleware(store, action, (dynamic a) {
      verifyNever(store.dispatch(anything));
      expect(a, isA<A>());
      expect(a, action);
    });
    verifyNever(store.dispatch(anything));
  }

  void checkCallingDispatchWith<A extends AsyncAction>(store, AsyncAction action, String routeName, bool removeStack) {
    action.status = RequestStatus.done;

    authMiddleware(store, action, (dynamic a) {
      verifyNever(store.dispatch(anything));
      expect(a, isA<A>());
      expect(a, action);
    });
    verify(store.dispatch(argThat(isA<PushRouteAction>()
            .having((e) => e.routeName, "route name", routeName)
            .having((e) => e.removeStack, "remove stack ?", removeStack))))
        .called(1);
  }

  test('authMiddleware with standard action must call next.', () {
    var store = MockedStore();
    var action = MockedAction();

    checkNotCallingDispatch<MockedAction>(store, action);
  });

  test('authMiddleware with RegisterAction that is not done must call next and not dispatch.', () {
    var store = MockedStore();
    var action = RegisterAction(
      RegisterRequest("email", "password", firstName: "firstName", lastName: "lastName"),
    );

    checkNotCallingDispatch<RegisterAction>(store, action);
  });

  test('authMiddleware with RegisterAction that is done redirect to Verify code page with stack reset', () {
    var store = MockedStore();
    var action = RegisterAction(
      RegisterRequest("email", "password", firstName: "firstName", lastName: "lastName"),
    );

    checkCallingDispatchWith<RegisterAction>(
      store,
      action,
      // VerifyingCodePage.routeName,
      "/",
      true,
    );
  });

  test('authMiddleware with LoginAction that is NOT done just next', () {
    var store = MockedStore();
    var action = LoginAction(
      LoginRequest("email", "password"),
    );

    checkNotCallingDispatch<LoginAction>(store, action);
  });

  test('authMiddleware with LoginAction that is done redirect to Store page with stack reset', () {
    var store = MockedStore();
    var action = LoginAction(
      LoginRequest("email", "password"),
    );

    checkCallingDispatchWith<LoginAction>(
      store,
      action,
      // StorePage.routeName,
      "/",
      true,
    );
  });

  test('authMiddleware with VerifyCodeAction that is NOT done just next', () {
    var store = MockedStore();
    var action = VerifyCodeAction(
      VerifyCodeRequest("code"),
    );

    checkNotCallingDispatch<VerifyCodeAction>(store, action);
  });

  // test('authMiddleware with VerifyCodeAction that is done redirect to Store page with stack reset', () {
  //   var store = MockedStore();
  //   var action = VerifyCodeAction(
  //     VerifyCodeRequest("code"),
  //   );

  //   checkCallingDispatchWith<VerifyCodeAction>(
  //     store,
  //     action,
  //     StorePage.routeName,
  //     true,
  //   );
  // });

  test('authMiddleware with LogoutAction that is done redirect to Login page with stack reset', () {
    var store = MockedStore();
    var action = LogoutAction();

    checkCallingDispatchWith<LogoutAction>(
      store,
      action,
      LoginPage.routeName,
      true,
    );
  });

  test('authMiddleware with RecoveryAction that is done redirect to password lost Modification page with stack reset',
      () {
    var store = MockedStore();
    var action = RecoveryAction(RecoveryRequest("email"));

    checkCallingDispatchWith<RecoveryAction>(
      store,
      action,
      ChangeLostPasswordPage.routeName,
      true,
    );
  });

  test('authMiddleware with ChangeLostPasswordAction that is done redirect to password login with stack reset', () {
    var store = MockedStore();
    var action = ChangeLostPasswordAction(ChangeLostPasswordRequest("email", "code", "password", "password"));

    checkCallingDispatchWith<ChangeLostPasswordAction>(
      store,
      action,
      LoginPage.routeName,
      true,
    );
  });

  test('authMiddleware with ChangePasswordAction that is done redirect to store page with stack reset', () {
    var store = MockedStore();
    var action = ChangePasswordAction(ChangePasswordRequest("oldPassword", "password", "password"));

    checkCallingDispatchWith<ChangePasswordAction>(
      store,
      action,
      StorePage.routeName,
      true,
    );
  });
}
