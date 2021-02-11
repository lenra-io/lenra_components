import 'dart:convert';

import 'package:fr_lenra_client/api/response_models/api_errors.dart';
import 'package:fr_lenra_client/redux/actions/action.dart';

/// The action to show an error to the client
class ShowErrorAction extends Action {
  final ApiErrors errors;

  ShowErrorAction(this.errors);

  Map<String, dynamic> toJson() => {
        'errors': jsonEncode(errors),
      };
}
