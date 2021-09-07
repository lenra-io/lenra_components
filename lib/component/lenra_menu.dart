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
      decoration: const BoxDecoration(
        color: LenraColorThemeData.lenraBlack,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: theme.baseSize,
          bottom: theme.baseSize,
        ),
        child: LenraFlex(
          direction: Axis.vertical,
          children: items,
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

  const LenraMenuItem({
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
    bool isDisabled = disabled || onPressed == null;

    Widget res = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.baseSize,
        vertical: theme.baseSize / 2,
      ),
      child: LenraFlex(
        fillParent: true,
        children: [
          SizedBox(
            height: theme.baseSize * 2,
            width: theme.baseSize * 2,
            child: isSelected
                ? icon ??
                    Icon(
                      Icons.done,
                      size: theme.baseSize * 2,
                      color: isDisabled ? LenraColorThemeData.lenraDisabledGray : LenraColorThemeData.lenraWhite,
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
        color: isSelected ? LenraColorThemeData.lenraBlue : Colors.transparent,
        child: InkWell(
          child: res,
          hoverColor: LenraColorThemeData.lenraBlueHover,
          onTap: () {
            onPressed!();
          },
        ),
      );
    }
  }
}
