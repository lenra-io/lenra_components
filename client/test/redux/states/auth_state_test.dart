import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/redux/states/async_status.dart';
import 'package:fr_lenra_client/redux/states/auth_state.dart';

void main() {
  test('auth state create', () {
    AuthState authState = AuthState();
    expect(authState.loginStatus != null, true);
    expect(authState.registerStatus != null, true);
    expect(authState.verifyCodeStatus != null, true);
    expect(authState.authResponse == null, true);
  });

  test('auth state copyWith', () {
    AuthState oldAuthState = AuthState();
    AuthState newAuthState = oldAuthState.copyWith(
      loginStatus: AsyncStatus(),
    );
    expect(identical(oldAuthState, newAuthState), false);
    expect(
      identical(oldAuthState.loginStatus, newAuthState.loginStatus),
      false,
    );
    expect(
      identical(oldAuthState.registerStatus, newAuthState.registerStatus),
      true,
    );
    expect(
      identical(oldAuthState.verifyCodeStatus, newAuthState.verifyCodeStatus),
      true,
    );
    expect(
      identical(oldAuthState.authResponse, newAuthState.authResponse),
      true,
    );
  });
}
