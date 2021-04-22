import 'package:flutter/material.dart';

class LenraColorThemeData {
  static const LENRA_WHITE = Colors.white;
  static const LENRA_BLUE = Color(0xFF1269ED);
  static const LENRA_BLUE_UNAVAILABLE = Color(0xFFD0E1FB);
  static const LENRA_PRIMARY_BLUE_HOVER = Color(0xFF0D4DAE);

  Color primaryBackgroundColor;
  Color primaryBackgroundHoverColor;
  Color primaryBackgroundDisabledColor;
  Color primaryForegroundColor;
  Color primaryForegroundHoverColor;
  Color primaryForegroundDisabledColor;

  Color secondaryBackgroundColor;
  Color secondaryBackgroundHoverColor;
  Color secondaryBackgroundDisabledColor;
  Color secondaryForegroundColor;
  Color secondaryForegroundHoverColor;
  Color secondaryForegroundDisabledColor;

  Color tertiaryBackgroundColor;
  Color tertiaryBackgroundHoverColor;
  Color tertiaryBackgroundDisabledColor;
  Color tertiaryForegroundColor;
  Color tertiaryForegroundHoverColor;
  Color tertiaryForegroundDisabledColor;

  LenraColorThemeData({
    Color primaryBackgroundColor,
    Color primaryBackgroundHoverColor,
    Color primaryBackgroundDisabledColor,
    Color primaryForegroundColor,
    Color primaryForegroundHoverColor,
    Color primaryForegroundDisabledColor,
    Color secondaryBackgroundColor,
    Color secondaryBackgroundHoverColor,
    Color secondaryBackgroundDisabledColor,
    Color secondaryForegroundColor,
    Color secondaryForegroundHoverColor,
    Color secondaryForegroundDisabledColor,
    Color tertiaryBackgroundColor,
    Color tertiaryBackgroundHoverColor,
    Color tertiaryBackgroundDisabledColor,
    Color tertiaryForegroundColor,
    Color tertiaryForegroundHoverColor,
    Color tertiaryForegroundDisabledColor,
  }) {
    this.primaryBackgroundColor = primaryBackgroundColor ?? LENRA_BLUE;
    this.primaryBackgroundHoverColor = primaryBackgroundHoverColor ?? LENRA_PRIMARY_BLUE_HOVER;
    this.primaryBackgroundDisabledColor = primaryBackgroundDisabledColor ?? LENRA_BLUE_UNAVAILABLE;
    this.primaryForegroundColor = primaryForegroundColor ?? LENRA_WHITE;
    this.primaryForegroundHoverColor = primaryForegroundHoverColor ?? LENRA_WHITE;
    this.primaryForegroundDisabledColor = primaryForegroundDisabledColor ?? LENRA_WHITE;
    this.secondaryBackgroundColor = secondaryBackgroundColor ?? Colors.transparent;
    this.secondaryBackgroundHoverColor = secondaryBackgroundHoverColor ?? LENRA_BLUE_UNAVAILABLE;
    this.secondaryBackgroundDisabledColor = secondaryBackgroundDisabledColor ?? Colors.transparent;
    this.secondaryForegroundColor = secondaryForegroundColor ?? LENRA_BLUE;
    this.secondaryForegroundHoverColor = secondaryForegroundHoverColor ?? LENRA_BLUE;
    this.secondaryForegroundDisabledColor = secondaryForegroundDisabledColor ?? LENRA_BLUE_UNAVAILABLE;
    this.tertiaryBackgroundColor = tertiaryBackgroundColor ?? Colors.transparent;
    this.tertiaryBackgroundHoverColor = tertiaryBackgroundHoverColor ?? LENRA_BLUE_UNAVAILABLE;
    this.tertiaryBackgroundDisabledColor = tertiaryBackgroundDisabledColor ?? Colors.transparent;
    this.tertiaryForegroundColor = tertiaryForegroundColor ?? LENRA_BLUE;
    this.tertiaryForegroundHoverColor = tertiaryForegroundHoverColor ?? LENRA_BLUE;
    this.tertiaryForegroundDisabledColor = tertiaryForegroundDisabledColor ?? LENRA_BLUE_UNAVAILABLE;
  }
}
