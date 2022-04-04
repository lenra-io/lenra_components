import 'package:flutter/material.dart';

class LenraColorThemeData {
  static const lenraWhite = Colors.white;
  static const lenraBlue = Color(0xFF1269ED);
  static const lenraBlueUnavailable = Color(0xFFD0E1FB);
  static const lenraBlueHover = Color(0xFF0D4DAE);
  static const lenraDisabledGray = Color(0xFFA9B2C4);
  static const lenraGreyText = Color(0xFF8B97AD);
  static const lenraBlack = Color(0xFF1E232C);
  static const lenraCustomRed = Color(0xFFF27A86);
  static const lenraCustomBlue = Color(0xFF70CBF2);
  static const lenraCustomYellow = Color(0xFFF6C28B);
  static const lenraCustomGreen = Color(0xFF57C0B3);

  static const greySuperLight = Color(0xFFF0F2F5);
  static const greyLight = Color(0xFFDCE0E7);
  static const greyNature = Color(0xFFA9B2C4);
  static const greyDarkGrey = Color(0xFF7A8598);
  static const blackMoon = Color(0xFF1E232C);

  static const lenraFunRedPulse = Color(0xFFE92236);
  static const lenraFunRedBase = Color(0xFFF27A86);
  static const lenraFunRedFade = Color(0xFFFACACF);

  static const lenraFunYellowPulse = Color(0xFFEF902C);
  static const lenraFunYellowBase = Color(0xFFF6C28B);
  static const lenraFunYellowFade = Color(0xFFFBE7D1);

  static const lenraFunGreenPulse = Color(0xFF389589);
  static const lenraFunGreenBase = Color(0xFF57C0B3);
  static const lenraFunGreenFade = Color(0xFFBCE6E1);

  static const lenraFunBluePulse = Color(0xFF19ACEA);
  static const lenraFunBlueBase = Color(0xFF70CBF2);
  static const lenraFunBlueFade = Color(0xFFC6EAFA);

  late Color primaryBackgroundColor;
  late Color primaryBackgroundHoverColor;
  late Color primaryBackgroundDisabledColor;
  late Color primaryForegroundColor;
  late Color primaryForegroundHoverColor;
  late Color primaryForegroundDisabledColor;

  late Color secondaryBackgroundColor;
  late Color secondaryBackgroundHoverColor;
  late Color secondaryBackgroundDisabledColor;
  late Color secondaryForegroundColor;
  late Color secondaryForegroundHoverColor;
  late Color secondaryForegroundDisabledColor;

  late Color tertiaryBackgroundColor;
  late Color tertiaryBackgroundHoverColor;
  late Color tertiaryBackgroundDisabledColor;
  late Color tertiaryForegroundColor;
  late Color tertiaryForegroundHoverColor;
  late Color tertiaryForegroundDisabledColor;

  LenraColorThemeData({
    Color? primaryBackgroundColor,
    Color? primaryBackgroundHoverColor,
    Color? primaryBackgroundDisabledColor,
    Color? primaryForegroundColor,
    Color? primaryForegroundHoverColor,
    Color? primaryForegroundDisabledColor,
    Color? secondaryBackgroundColor,
    Color? secondaryBackgroundHoverColor,
    Color? secondaryBackgroundDisabledColor,
    Color? secondaryForegroundColor,
    Color? secondaryForegroundHoverColor,
    Color? secondaryForegroundDisabledColor,
    Color? tertiaryBackgroundColor,
    Color? tertiaryBackgroundHoverColor,
    Color? tertiaryBackgroundDisabledColor,
    Color? tertiaryForegroundColor,
    Color? tertiaryForegroundHoverColor,
    Color? tertiaryForegroundDisabledColor,
  }) {
    this.primaryBackgroundColor = primaryBackgroundColor ?? lenraBlue;
    this.primaryBackgroundHoverColor = primaryBackgroundHoverColor ?? lenraBlueHover;
    this.primaryBackgroundDisabledColor = primaryBackgroundDisabledColor ?? lenraBlueUnavailable;
    this.primaryForegroundColor = primaryForegroundColor ?? lenraWhite;
    this.primaryForegroundHoverColor = primaryForegroundHoverColor ?? lenraWhite;
    this.primaryForegroundDisabledColor = primaryForegroundDisabledColor ?? lenraWhite;

    this.secondaryBackgroundColor = secondaryBackgroundColor ?? Colors.white;
    this.secondaryBackgroundHoverColor = secondaryBackgroundHoverColor ?? lenraBlueUnavailable;
    this.secondaryBackgroundDisabledColor = secondaryBackgroundDisabledColor ?? Colors.white;
    this.secondaryForegroundColor = secondaryForegroundColor ?? lenraBlue;
    this.secondaryForegroundHoverColor = secondaryForegroundHoverColor ?? lenraBlue;
    this.secondaryForegroundDisabledColor = secondaryForegroundDisabledColor ?? lenraBlueUnavailable;

    this.tertiaryBackgroundColor = tertiaryBackgroundColor ?? Colors.white;
    this.tertiaryBackgroundHoverColor = tertiaryBackgroundHoverColor ?? lenraBlueUnavailable;
    this.tertiaryBackgroundDisabledColor = tertiaryBackgroundDisabledColor ?? Colors.white;
    this.tertiaryForegroundColor = tertiaryForegroundColor ?? lenraBlue;
    this.tertiaryForegroundHoverColor = tertiaryForegroundHoverColor ?? lenraBlue;
    this.tertiaryForegroundDisabledColor = tertiaryForegroundDisabledColor ?? lenraBlueUnavailable;
  }

  copyWith({
    Color? primaryBackgroundColor,
    Color? primaryBackgroundHoverColor,
    Color? primaryBackgroundDisabledColor,
    Color? primaryForegroundColor,
    Color? primaryForegroundHoverColor,
    Color? primaryForegroundDisabledColor,
    Color? secondaryBackgroundColor,
    Color? secondaryBackgroundHoverColor,
    Color? secondaryBackgroundDisabledColor,
    Color? secondaryForegroundColor,
    Color? secondaryForegroundHoverColor,
    Color? secondaryForegroundDisabledColor,
    Color? tertiaryBackgroundColor,
    Color? tertiaryBackgroundHoverColor,
    Color? tertiaryBackgroundDisabledColor,
    Color? tertiaryForegroundColor,
    Color? tertiaryForegroundHoverColor,
    Color? tertiaryForegroundDisabledColor,
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
