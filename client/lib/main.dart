import 'package:flutter/material.dart';
import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/redux/store.dart';

void main() async {
  var store = await LenraStore.loadStore();
  runApp(Lenra(store: store));
}
