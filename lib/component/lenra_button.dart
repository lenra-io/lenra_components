import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/theme/lenra_button_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final bool disabled;
  final LenraComponentSize size;
  final LenraComponentType type;
  final Widget? leftIcon;
  final Widget? rightIcon;

  LenraButton({
    @required this.onPressed,
    this.text,
    this.disabled = false,
    this.size = LenraComponentSize.Medium,
    this.type = LenraComponentType.Primary,
    this.leftIcon,
    this.rightIcon,
    Key? key,
  })  : assert(text != null || leftIcon != null || rightIcon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraButtonThemeData finalLenraButtonThemeData = LenraTheme.of(context).lenraButtonThemeData;

    List<Widget> children = [];
    Widget res;

    if (this.leftIcon != null) {
      children.add(this.leftIcon!);
    }

    if (this.text != null) {
      var tempText = Text(
        text!,
        textAlign: TextAlign.center,
        strutStyle: StrutStyle(leading: 0.15),
      );

      if (this.leftIcon != null || this.rightIcon != null) {
        children.add(
          Flexible(child: tempText),
        );
      } else {
        children.add(tempText);
      }
    }

    if (this.rightIcon != null) {
      children.add(this.rightIcon!);
    }

    if (children.length > 1) {
      res = LenraFlex(
        spacing: 1.5,
        children: children,
      );
    } else {
      res = children.first;
    }

    // Manage size
    return TextButton(
      onPressed: this.disabled ? () {} : onPressed,
      child: Padding(
        padding: finalLenraButtonThemeData.getPadding(size),
        child: res,
      ),
      style: finalLenraButtonThemeData.getStyle(type),
    );
  }
}
