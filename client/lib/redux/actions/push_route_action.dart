import 'package:fr_lenra_client/redux/actions/action.dart';

/// An action to do a redirection
class PushRouteAction extends Action {
  final String routeName;
  final Object arguments;
  final bool removeStack;

  /// Creates a PushRouteAction
  ///
  /// The action redirects on the new route [routeName], the previous route can be disposed by setting the [removeStack] argument to true.
  PushRouteAction(this.routeName, {this.arguments, this.removeStack = false});
}
