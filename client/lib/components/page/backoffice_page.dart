import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/components/page/backoffice/side_menu.dart';
import 'package:fr_lenra_client/components/page/backoffice/top_bar.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class BackofficePage extends StatelessWidget {
  final AppResponse? selectedApp;
  final Widget child;
  final Widget? title;
  final Widget? mainActionWidget;

  const BackofficePage({
    Key? key,
    this.selectedApp,
    this.title,
    this.mainActionWidget,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    return Scaffold(
      backgroundColor: LenraColorThemeData.LENRA_WHITE,
      body: Row(
        children: [
          BackofficeSideMenu(
            selectedApp: selectedApp,
          ),
          Expanded(
            child: SizedBox.expand(
              child: Column(children: [
                if (title != null || mainActionWidget != null)
                  BackofficeTopBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (title != null) title!,
                        if (mainActionWidget != null) mainActionWidget!,
                      ],
                    ),
                  ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.all(theme.baseSize * 4),
                    child: child,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
