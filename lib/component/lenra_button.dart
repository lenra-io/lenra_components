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

  const LenraButton({
    required this.onPressed,
    this.text,
    this.disabled = false,
    this.size = LenraComponentSize.medium,
    this.type = LenraComponentType.primary,
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

    if (leftIcon != null) {
      children.add(leftIcon!);
    }

    if (text != null) {
      var tempText = Text(
        text!,
        textAlign: TextAlign.center,
        strutStyle: const StrutStyle(leading: 0.15),
      );

      if (leftIcon != null || rightIcon != null) {
        children.add(
          Flexible(child: tempText),
        );
      } else {
        children.add(tempText);
      }
    }

    if (rightIcon != null) {
      children.add(rightIcon!);
    }

    if (children.length > 1) {
      res = LenraFlex(
        spacing: 1.5,
        children: children,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    } else {
      res = children.first;
    }

    // Manage size
    return TextButton(
      onPressed: disabled ? null : onPressed,
      child: Padding(
        padding: finalLenraButtonThemeData.getPadding(size),
        child: res,
      ),
      style: finalLenraButtonThemeData.getStyle(type),
    );
  }
}
