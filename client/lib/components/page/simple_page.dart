import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class SimplePage extends StatelessWidget {
  final String title;
  final String backInkText;
  final Function backInkAction;
  final Widget child;

  const SimplePage({
    Key key,
    this.title,
    this.child,
    this.backInkText,
    this.backInkAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    List<Widget> children = [
      Image.asset(
        'assets/images/logo-vertical.png',
        width: 96,
      )
    ];
    if (title != null && title.isNotEmpty)
      children.add(Text(
        title,
        style: theme.lenraTextThemeData.headline1,
        textAlign: TextAlign.center,
      ));
    if (child != null) children.add(child);
    return Scaffold(
      body: Column(
        children: _buildBackInk(context, theme)
          ..add(Center(
            child: new Container(
              width: 400,
              child: LenraColumn(
                children: children,
                separationFactor: 5,
              ),
            ),
          )),
      ),
    );
  }

  List<Widget> _buildBackInk(BuildContext context, LenraThemeData theme) {
    var size = MediaQuery.of(context).size;
    var padding = min(min(size.height * 0.08, size.width * 0.1), theme.baseSize * 10);
    var inkSize = 20;
    var separation = min(min(size.height * 0.05, size.width * 0.06), theme.baseSize * 6);
    if (backInkText == null || backInkText.isEmpty)
      return [
        SizedBox(
          height: padding + inkSize + separation,
        )
      ];
    var linkTheme = theme.lenraTextThemeData.bodyText.copyWith(color: theme.lenraColorThemeData.primaryBackgroundColor);
    return [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: padding, left: padding, bottom: separation),
          child: InkWell(
              onTap: backInkAction ?? () {},
              child: LenraRow(
                separationFactor: 1.5,
                children: [
                  Text("<", style: linkTheme),
                  Text(backInkText, style: linkTheme),
                ],
              )),
        ),
      )
    ];
  }
}
