import 'package:flutter/material.dart';

class LenraColorThemeData {
  static const LENRA_WHITE = Colors.white;
  static const LENRA_BLUE = Color(0xFF1269ED);
  static const LENRA_BLUE_UNAVAILABLE = Color(0xFFD0E1FB);
  static const LENRA_BLUE_HOVER = Color(0xFF0D4DAE);
  static const LENRA_DISABLED_GRAY = Color(0xFFA9B2C4);
  static const LENRA_GREY_TEXT = Color(0xFF8B97AD);
  static const LENRA_BLACK = Color(0xFF1E232C);
  static const LENRA_CUSTOM_RED = Color(0xFFF27A86);
  static const LENRA_CUSTOM_BLUE = Color(0xFF70CBF2);
  static const LENRA_CUSTOM_YELLOW = Color(0xFFF6C28B);
  static const LENRA_CUSTOM_GREEN = Color(0xFF57C0B3);

  static const LENRA_FUN_RED_PULSE = Color(0xFFE92236);
  static const LENRA_FUN_RED_BASE = Color(0xFFF27A86);
  static const LENRA_FUN_RED_FADE = Color(0xFFFACACF);

  static const LENRA_FUN_YELLOW_PULSE = Color(0xFFEF902C);
  static const LENRA_FUN_YELLOW_BASE = Color(0xFFF6C28B);
  static const LENRA_FUN_YELLOW_FADE = Color(0xFFFBE7D1);

  static const LENRA_FUN_GREEN_PULSE = Color(0xFF389589);
  static const LENRA_FUN_GREEN_BASE = Color(0xFF57C0B3);
  static const LENRA_FUN_GREEN_FADE = Color(0xFFBCE6E1);

  static const LENRA_FUN_BLUE_PULSE = Color(0xFF19ACEA);
  static const LENRA_FUN_BLUE_BASE = Color(0xFF70CBF2);
  static const LENRA_FUN_BLUE_FADE = Color(0xFFC6EAFA);

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
    this.primaryBackgroundHoverColor = primaryBackgroundHoverColor ?? LENRA_BLUE_HOVER;
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

  copyWith({
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
    return LenraColorThemeData(
      primaryBackgroundColor: primaryBackgroundColor ?? this.primaryBackgroundColor,
      primaryBackgroundHoverColor: primaryBackgroundHoverColor ?? this.primaryBackgroundHoverColor,
      primaryBackgroundDisabledColor: primaryBackgroundDisabledColor ?? this.primaryBackgroundDisabledColor,
      primaryForegroundColor: primaryForegroundColor ?? this.primaryForegroundColor,
      primaryForegroundHoverColor: primaryForegroundHoverColor ?? this.primaryForegroundColor,
      primaryForegroundDisabledColor: primaryForegroundDisabledColor ?? this.primaryForegroundDisabledColor,
      secondaryBackgroundColor: secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      secondaryBackgroundHoverColor: secondaryBackgroundHoverColor ?? this.secondaryBackgroundHoverColor,
      secondaryBackgroundDisabledColor: secondaryBackgroundDisabledColor ?? this.secondaryBackgroundDisabledColor,
      secondaryForegroundColor: secondaryForegroundColor ?? this.secondaryForegroundColor,
      secondaryForegroundHoverColor: secondaryForegroundHoverColor ?? this.secondaryForegroundHoverColor,
      secondaryForegroundDisabledColor: secondaryForegroundDisabledColor ?? this.secondaryForegroundDisabledColor,
      tertiaryBackgroundColor: tertiaryBackgroundColor ?? this.tertiaryBackgroundColor,
      tertiaryBackgroundHoverColor: tertiaryBackgroundHoverColor ?? this.tertiaryBackgroundHoverColor,
      tertiaryBackgroundDisabledColor: tertiaryBackgroundDisabledColor ?? this.tertiaryBackgroundDisabledColor,
      tertiaryForegroundColor: tertiaryForegroundColor ?? this.tertiaryForegroundColor,
      tertiaryForegroundHoverColor: tertiaryForegroundHoverColor ?? this.tertiaryForegroundHoverColor,
      tertiaryForegroundDisabledColor: tertiaryForegroundDisabledColor ?? this.tertiaryForegroundDisabledColor,
    );
  }
}
