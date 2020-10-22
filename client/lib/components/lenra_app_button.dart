import 'package:flutter/material.dart';
import 'package:fr_lenra_client/apps/lenra_application_info.dart';

class AppButton extends StatelessWidget {
  AppButton({Key key, this.appInfo, this.onPressed}) : super(key: key);

  final LenraApplicationInfo appInfo;
  final VoidCallback onPressed;

  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          color: appInfo.color,
          child: InkWell(
            child: Container(
                width: 120,
                padding: EdgeInsets.all(8),
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Icon(
                          appInfo.icon,
                          size: 64,
                        )),
                    Text(appInfo.name)
                  ],
                ))),
            onTap: this.onPressed,
          ),
        ),
      ),
    );
  }
}
