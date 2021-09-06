import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_menu_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraMenu extends StatelessWidget {
  final List<LenraMenuItem> items;

  LenraMenu({
    Key? key,
    required this.items,
  })  : assert(items.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData theme = LenraTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: LenraColorThemeData.LENRA_BLACK,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: theme.baseSize,
          bottom: theme.baseSize,
        ),
        child: LenraFlex(
          direction: Axis.vertical,
          children: this.items,
        ),
      ),
    );
  }
}

class LenraMenuItem extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isSelected;
  final bool disabled;
  final Widget? icon;

  LenraMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.disabled = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraMenuThemeData lenraMenuThemeData = LenraTheme.of(context).lenraMenuThemeData;
    final LenraThemeData theme = LenraTheme.of(context);

    /// LenraMenuItem can be disabled both by the [disabled] or [onPressed] parameters.
    bool isDisabled = this.disabled || onPressed == null;

    Widget res = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.baseSize,
        vertical: theme.baseSize / 2,
      ),
      child: LenraFlex(
        fillParent: true,
        children: [
          Container(
            height: theme.baseSize * 2,
            width: theme.baseSize * 2,
            child: this.isSelected
                ? this.icon ??
                    Icon(
                      Icons.done,
                      size: theme.baseSize * 2,
                      color: isDisabled ? LenraColorThemeData.LENRA_DISABLED_GRAY : LenraColorThemeData.LENRA_WHITE,
                    )
                : null,
          ),
          Text(
            text,
            style: isDisabled ? theme.lenraTextThemeData.disabledBodyText : lenraMenuThemeData.menuText,
          ),
        ],
      ),
    );

    if (isDisabled) {
      return res;
    } else {
      // According to Flutter documentation an InkWell must have a Material ancestor
      // See https://api.flutter.dev/flutter/material/InkWell-class.html
      return Material(
        color: this.isSelected ? LenraColorThemeData.LENRA_BLUE : Colors.transparent,
        child: InkWell(
          child: res,
          hoverColor: LenraColorThemeData.LENRA_BLUE_HOVER,
          onTap: () {
            onPressed!();
          },
        ),
      );
    }
  }
}
