import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

enum LenraButtonType {
  Primary,
  Secondary,
  Tertiary,
}

class LenraButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool disabled;
  final LenraComponentSize size;
  final LenraButtonType type;
  final LenraButtonThemeData lenraButtonThemeData;
  final Widget leftIcon;
  final Widget rightIcon;

  LenraButton({
    this.onPressed,
    this.text,
    this.disabled = false,
    this.size = LenraComponentSize.Medium,
    this.type = LenraButtonType.Primary,
    this.lenraButtonThemeData,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final LenraButtonThemeData finalLenraButtonThemeData =
        LenraTheme.of(context).lenraButtonThemeData.merge(this.lenraButtonThemeData);

    Widget child = Text(
      text,
      textAlign: TextAlign.center,
      strutStyle: StrutStyle(leading: 0.15),
    );

    if (this.leftIcon != null || this.rightIcon != null) {
      child = LenraRow(
        separationFactor: 1.5,
        children: [
          if (this.leftIcon != null) this.leftIcon,
          Expanded(child: child),
          if (this.rightIcon != null) this.rightIcon,
        ],
      );
    }

    // Manage size
    return TextButton(
      onPressed: this.disabled ? null : onPressed ?? () {},
      child: Padding(
        padding: finalLenraButtonThemeData.padding.resolve(this.size),
        child: child,
      ),
      style: ButtonStyle(
        textStyle: finalLenraButtonThemeData.textStyle,
        foregroundColor: finalLenraButtonThemeData.foregroundColor.resolve(this.type),
        backgroundColor: finalLenraButtonThemeData.backgroundColor.resolve(this.type),
        side: finalLenraButtonThemeData.side.resolve(this.type),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
