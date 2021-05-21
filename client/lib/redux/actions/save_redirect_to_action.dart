import 'package:flutter/material.dart';
import 'package:fr_lenra_client/redux/actions/action.dart' as Lenra;

class SaveRedirectToAction extends Lenra.Action {
  String redirectToRoute;

  SaveRedirectToAction({@required this.redirectToRoute});
}
