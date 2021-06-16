import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';

class AppButton extends StatelessWidget {
  final AppResponse appInfo;
  final VoidCallback onPressed;

  AppButton({
    Key? key,
    required this.appInfo,
    required this.onPressed,
  }) : super(key: key);

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
