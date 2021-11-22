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
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider<Object>? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final MaterialTapTargetSize? materialTapTargetSize;

  const LenraToggleStyle({
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.hoverColor,
    this.focusColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
  });
}