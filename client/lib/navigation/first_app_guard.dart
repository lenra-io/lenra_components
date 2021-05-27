import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/navigation/page_guard.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/store.dart';
import 'package:fr_lenra_client/service/application_model.dart';
import 'package:provider/provider.dart';

class FirstAppGuard extends PageGuard {
  FirstAppGuard({
    bool hasApplication = true,
  }) : super(
          isAuthorized: (context) async {
            //var userApps = await ApplicationService.instance.loadUserApplications();
            var userApps = await context.read<ApplicationModel>().fetchUserApplications();
            return hasApplication == userApps.isNotEmpty;
          },
          ifUnauthorized: (context) {
            LenraStore.dispatch(PushRouteAction(hasApplication ? LenraNavigator.WELCOME : LenraNavigator.HOME_ROUTE));
          },
        );
}
