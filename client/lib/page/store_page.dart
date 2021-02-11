import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/store_page/app_list_container.dart';

class StorePage extends StatefulWidget {
  static const routeName = '/';

  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Container(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Container(
                child: AppListContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
