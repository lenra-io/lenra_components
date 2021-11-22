import 'dart:ui';

import 'package:flutter/material.dart';

class LenraTextFieldStyle {
  final Color? cursorColor;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final double? cursorWidth;
  final InputDecoration? decoration; // How to handle this one?
  final Brightness? keyboardAppearance;
  final String? obscuringCharacter;
  final EdgeInsets? scrollPadding;
  final BoxHeightStyle? selectionHeightStyle;
  final BoxWidthStyle? selectionWidthStyle;
  final StrutStyle? strutStyle;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;

  LenraTextFieldStyle({
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth,
    this.decoration,
    this.keyboardAppearance,
    this.obscuringCharacter,
    this.scrollPadding,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.strutStyle,
    this.textStyle,
    this.textAlign,
    this.textAlignVertical,
  });
}