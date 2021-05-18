import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

enum LenraButtonSize {
  Small,
  Medium,
  Large,
}

enum LenraButtonType {
  Primary,
  Secondary,
  Tertiary,
}

class LenraButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool disabled;
  final LenraButtonSize size;
  final LenraButtonType type;
  final LenraButtonThemeData lenraButtonThemeData;
  final Widget leftIcon;
  final Widget rightIcon;

  LenraButton({
    this.onPressed,
    this.text,
    this.disabled = false,
    this.size = LenraButtonSize.Medium,
    this.type = LenraButtonType.Primary,
    this.lenraButtonThemeData,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final LenraButtonThemeData finalLenraButtonThemeData =
        LenraTheme.of(context).lenraButtonThemeData.merge(this.lenraButtonThemeData);

    Widget textButtonChild = Text(text);

    if (this.leftIcon != null || this.rightIcon != null) {
      textButtonChild = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (this.leftIcon != null) this.leftIcon,
          Text(text),
          if (this.rightIcon != null) this.rightIcon,
        ],
      );
    }

    return TextButton(
      onPressed: this.disabled ? null : onPressed,
      child: textButtonChild,
      style: ButtonStyle(
        textStyle: finalLenraButtonThemeData.textStyle,
        padding: finalLenraButtonThemeData.padding,
        foregroundColor: finalLenraButtonThemeData.foregroundColor.resolve(this.type),
        backgroundColor: finalLenraButtonThemeData.backgroundColor.resolve(this.type),
        minimumSize: finalLenraButtonThemeData.minimumSize.resolve(this.size),
        side: finalLenraButtonThemeData.side.resolve(this.type),
      ),
    );
  }
}
