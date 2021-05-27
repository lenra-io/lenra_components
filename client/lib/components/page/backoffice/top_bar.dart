import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class BackofficeTopBar extends StatelessWidget {
  final Widget title;

  const BackofficeTopBar({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 2 * theme.baseSize,
        horizontal: 4 * theme.baseSize,
      ),
      decoration: BoxDecoration(
        color: LenraColorThemeData.LENRA_WHITE,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 1), // changes position of shadow
          ),
          BoxShadow(
            color: LenraColorThemeData.LENRA_DISABLED_GRAY.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 16,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: theme.lenraTextThemeData.bodyText.merge(theme.lenraTextThemeData.headline2),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: this.title,
      ),
    );
  }
}
