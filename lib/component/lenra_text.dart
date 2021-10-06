import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_text_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraText extends StatelessWidget {
  final String? text;
  final LenraTextStyle style;

  const LenraText(
    this.text, {
    this.style = LenraTextStyle.bodyText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    return Text(
      text!,
      style: finalLenraTextThemeData.getStyle(style),
    );
  }
}
