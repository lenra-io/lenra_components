import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/components/page/lenra_app_page.dart';
import 'package:fr_lenra_client/components/page/login_page.dart';
import 'package:fr_lenra_client/components/page/register_page.dart';
import 'package:fr_lenra_client/components/page/store_page.dart';
import 'package:fr_lenra_client/components/page/verifiying_code_page.dart';
import 'package:fr_lenra_client/navigation_helper.dart';

void main() {
  test('expect all routes to be registred', () {
    expect(routes.containsKey(LoginPage.routeName), true);
    expect(routes.containsKey(VerifyingCodePage.routeName), true);
    expect(routes.containsKey(RegisterPage.routeName), true);
    expect(routes.containsKey(StorePage.routeName), true);
    expect(routes.containsKey(LenraAppPage.routeName), true);
  });
}
