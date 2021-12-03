import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class LenraToggleStyle {
  final Color activeColor = LenraColorThemeData.lenraFunGreenBase;
  final Color? activeTrackColor;
  final Color inactiveTrackColor = LenraColorThemeData.greyNature;
  final Color? inactiveThumbColor;
  final Color? hoverColor;
  final Color? focusColor;
  final ImageProvider<Object>? activeThumbImage;
  final ImageProvider<Object>? inactiveThumbImage;
  final MaterialTapTargetSize? materialTapTargetSize;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageErrorListener? onInactiveThumbImageError;

  const LenraToggleStyle({
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.hoverColor,
    this.focusColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.materialTapTargetSize,
    this.onInactiveThumbImageError,
    this.onActiveThumbImageError,
  });
}
