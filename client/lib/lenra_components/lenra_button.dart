import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_button_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool disabled;
  final LenraComponentSize size;
  final LenraComponentType type;
  final Widget? leftIcon;
  final Widget? rightIcon;

  LenraButton({
    @required this.onPressed,
    required this.text,
    this.disabled = false,
    this.size = LenraComponentSize.Medium,
    this.type = LenraComponentType.Primary,
    this.leftIcon,
    this.rightIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraButtonThemeData finalLenraButtonThemeData = LenraTheme.of(context).lenraButtonThemeData;

    Widget child = Text(
      text,
      textAlign: TextAlign.center,
      strutStyle: StrutStyle(leading: 0.15),
    );

    if (this.leftIcon != null || this.rightIcon != null) {
      child = LenraRow(
        separationFactor: 1.5,
        children: [
          if (this.leftIcon != null) this.leftIcon!,
          Expanded(child: child),
          if (this.rightIcon != null) this.rightIcon!,
        ],
      );
    }

    // Manage size
    return TextButton(
      onPressed: this.disabled ? () {} : onPressed,
      child: Padding(
        padding: finalLenraButtonThemeData.getPadding(size),
        child: child,
      ),
      style: finalLenraButtonThemeData.getStyle(type),
    );
  }
}
