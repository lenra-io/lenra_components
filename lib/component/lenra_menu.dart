import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_column.dart';
import 'package:lenra_components/layout/lenra_row.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_menu_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraMenu extends StatelessWidget {
  final List<LenraMenuItem> items;

  LenraMenu({
    required this.items,
  }) : assert(items.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData theme = LenraTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.lenraBorderThemeData.borderRadius,
        color: LenraColorThemeData.LENRA_BLACK,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: theme.baseSize,
          bottom: theme.baseSize,
        ),
        child: LenraColumn(
          children: this.items,
        ),
      ),
    );
  }
}

class LenraMenuItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool disabled;
  final Function()? onPressed;

  LenraMenuItem({
    required this.text,
    this.isSelected = false,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final LenraMenuThemeData lenraMenuThemeData = LenraTheme.of(context).lenraMenuThemeData;
    final LenraThemeData theme = LenraTheme.of(context);

    Container res = Container(
      color: this.isSelected ? LenraColorThemeData.LENRA_BLUE : Colors.transparent,
      child: LenraRow(
        fillParent: true,
        children: [
          Padding(
            padding: EdgeInsets.only(left: theme.baseSize),
            child: this.isSelected
                ? Icon(
                    Icons.done,
                    size: theme.baseSize,
                    color: LenraColorThemeData.LENRA_WHITE,
                  )
                : SizedBox(
                    width: theme.baseSize,
                  ),
          ),
          Padding(
            // TODO: Check if Figma is correct because we should not have to divide baseSize by such numbers
            //  Text is 14 and LenraMenuItem is 24 so vertical is 5 top 5 bottom.
            //  On Figma it is : Text 19 and vertical top 2.5 bottom 2.5 which is worse
            padding: EdgeInsets.symmetric(
              horizontal: theme.baseSize,
              vertical: theme.baseSize / 1.6,
            ),
            child: Text(
              text,
              style: this.disabled ? theme.lenraTextThemeData.disabledBodyText : lenraMenuThemeData.menuText,
            ),
          ),
        ],
      ),
    );

    if (this.disabled) {
      return res;
    } else {
      return InkWell(
        child: res,
        onTap: () {
          if (!this.disabled) onPressed!();
        },
      );
    }
  }
}
