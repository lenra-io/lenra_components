import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraStatusSticker extends StatelessWidget {
  final Color? color;

  const LenraStatusSticker({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData lenraThemeData = LenraTheme.of(context);

    return Container(
      width: lenraThemeData.baseSize,
      height: lenraThemeData.baseSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
