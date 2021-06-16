import 'package:flutter/material.dart';
import 'package:fr_lenra_client/api/response_models/app_response.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BackofficeSideMenu extends StatelessWidget {
  final AppResponse? selectedApp;

  const BackofficeSideMenu({
    Key? key,
    this.selectedApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    return Container(
      width: 196,
      color: LenraColorThemeData.LENRA_BLACK,
      child: LenraTheme(
        themeData: theme.copyWith(
          lenraTextThemeData: theme.lenraTextThemeData.copyWith(
            bodyText: theme.lenraTextThemeData.bodyText.copyWith(
              color: LenraColorThemeData.LENRA_WHITE,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: theme.baseSize * 3,
                horizontal: theme.baseSize * 6,
              ),
              child: Image.asset('images/logo-horizontal-white.png'),
            ),
            Expanded(
              child: SizedBox.expand(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: _ProjectMenu(selectedApp: selectedApp),
                  ),
                ),
              ),
            ),
            Column(children: [
              BackofficeSideMenuItem(
                "Account",
                icon: Icons.account_circle_outlined,
                disabled: true,
              ),
              BackofficeSideMenuItem(
                "Documentation",
                icon: Icons.book_outlined,
                disabled: true,
                onPressed: () async {
                  const url = "https://doc.lenra.io";
                  if (await canLaunch(url))
                    await launch(url);
                  else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                },
              ),
              BackofficeSideMenuItem(
                "Logout",
                icon: Icons.logout,
                onPressed: () async {
                  try {
                    await context.read<AuthModel>().logout();
                    Navigator.of(context).pushReplacementNamed(LenraNavigator.LOGIN_ROUTE);
                  } catch (e) {}
                },
              ),
              BackofficeSideMenuItem(
                "Contact us",
                icon: Icons.messenger_outline_rounded,
                onPressed: () async {
                  const url = "mailto:contact@lenra.io";
                  if (await canLaunch(url))
                    await launch(url);
                  else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                },
              ),
            ]),
            SizedBox(height: theme.baseSize * 2)
          ],
        ),
      ),
    );
  }
}

class _ProjectMenu extends StatelessWidget {
  final AppResponse? selectedApp;

  const _ProjectMenu({Key? key, this.selectedApp}) : super(key: key);

  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    if (this.selectedApp == null) return SizedBox.shrink();
    return Column(children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: theme.baseSize * 3,
          horizontal: theme.baseSize * 2,
        ),
        child: LenraColumn(
          separationFactor: 0.5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedApp!.name,
              style: theme.lenraTextThemeData.headline2,
            ),
            LenraRow(
              children: [
                Icon(
                  Icons.circle,
                  color: selectedApp!.public
                      ? LenraColorThemeData.LENRA_CUSTOM_GREEN
                      : LenraColorThemeData.LENRA_CUSTOM_RED,
                  size: theme.baseSize,
                ),
                Text(
                  "${selectedApp!.public ? 'Public' : 'Private'} access",
                ),
              ],
            ),
          ],
        ),
      ),
      BackofficeSideMenuRoute(
        "Overview",
        icon: Icons.bookmark_border_rounded,
        route: LenraNavigator.HOME_ROUTE,
      ),
      BackofficeSideMenuRoute(
        "Envrironments",
        icon: Icons.layers_outlined,
        disabled: true,
        route: "null",
      ),
      BackofficeSideMenuRoute(
        "Builds",
        icon: Icons.bolt,
        disabled: true,
        route: "null",
      ),
      BackofficeSideMenuRoute(
        "Settings",
        icon: Icons.settings_outlined,
        disabled: true,
        route: LenraNavigator.SETTINGS,
      ),
    ]);
  }
}

class BackofficeSideMenuItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool selected;
  final bool disabled;
  final GestureTapCallback? onPressed;

  const BackofficeSideMenuItem(
    this.text, {
    Key? key,
    this.icon,
    this.selected = false,
    this.disabled = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    var color =
        this.disabled ? theme.lenraTextThemeData.disabledBodyText.color : theme.lenraTextThemeData.bodyText.color;
    var ret = Container(
      color: this.selected ? LenraColorThemeData.LENRA_BLUE : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: theme.baseSize * 2, vertical: theme.baseSize),
      width: double.infinity,
      child: Row(children: [
        Container(
          width: theme.baseSize * 3.5,
          child: icon != null
              ? Icon(
                  this.icon,
                  color: color,
                  size: theme.baseSize * 2,
                )
              : null,
        ),
        Text(
          this.text,
          style: TextStyle(color: color),
          textAlign: TextAlign.left,
        ),
      ]),
    );
    if (disabled || onPressed == null) return ret;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        hoverColor: LenraColorThemeData.LENRA_BLUE_HOVER,
        child: ret,
      ),
    );
  }
}

class BackofficeSideMenuRoute extends StatelessWidget {
  final String text;
  final String route;
  final IconData? icon;
  final bool disabled;

  const BackofficeSideMenuRoute(
    this.text, {
    Key? key,
    required this.route,
    this.icon,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isCurrent = LenraNavigator.currentRoute == route;
    return BackofficeSideMenuItem(
      text,
      icon: icon,
      disabled: disabled,
      selected: isCurrent,
      onPressed: (!disabled && !isCurrent) ? () => Navigator.of(context).pushNamed(route) : null,
    );
  }
}
