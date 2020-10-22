import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    FlutterError args = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: Center(child: Text(args.message)));
  }
}
