import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

class LenraBorderThemeData {
  late BorderRadius borderRadius;
  late BorderSide primaryBorder;
  late BorderSide primaryHoverBorder;
  late BorderSide primaryDisabledBorder;

  late BorderSide secondaryBorder;
  late BorderSide secondaryHoverBorder;
  late BorderSide secondaryDisabledBorder;

  late BorderSide? tertiaryBorder;
  late BorderSide? tertiaryHoverBorder;
  late BorderSide? tertiaryDisabledBorder;

  late BorderSide errorBorder;

  LenraBorderThemeData({
    BorderRadius? borderRadius,
    BorderSide? primaryBorder,
    BorderSide? primaryHoverBorder,
    BorderSide? primaryDisabledBorder,
    BorderSide? secondaryBorder,
    BorderSide? secondaryHoverBorder,
    BorderSide? secondaryDisabledBorder,
    this.tertiaryBorder,
    this.tertiaryHoverBorder,
    this.tertiaryDisabledBorder,
    BorderSide? errorBorder,
  }) {
    /* TODO: set default value for all border*/
    this.borderRadius = borderRadius ?? BorderRadius.circular(4.0);
    this.primaryBorder = primaryBorder ?? const BorderSide(color: Colors.grey);
    this.primaryHoverBorder = primaryHoverBorder ?? const BorderSide(color: LenraColorThemeData.lenraBlue);
    this.primaryDisabledBorder =
        primaryDisabledBorder ?? const BorderSide(color: LenraColorThemeData.lenraDisabledGray);
    this.secondaryBorder = secondaryBorder ?? const BorderSide(color: LenraColorThemeData.lenraBlue);
    this.secondaryHoverBorder = secondaryHoverBorder ?? const BorderSide(color: LenraColorThemeData.lenraBlue);
    this.secondaryDisabledBorder =
        secondaryDisabledBorder ?? const BorderSide(color: LenraColorThemeData.lenraBlueUnavailable);
    this.errorBorder = errorBorder ?? const BorderSide(color: LenraColorThemeData.lenraCustomRed);
  }

  copyWith({
    BorderRadius? borderRadius,
    BorderSide? primaryBorder,
    BorderSide? primaryHoverBorder,
    BorderSide? primaryDisabledBorder,
    BorderSide? secondaryBorder,
    BorderSide? secondaryHoverBorder,
    BorderSide? secondaryDisabledBorder,
    BorderSide? tertiaryBorder,
    BorderSide? tertiaryHoverBorder,
    BorderSide? tertiaryDisabledBorder,
  }) {
    return LenraBorderThemeData(
      borderRadius: borderRadius ?? this.borderRadius,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      primaryHoverBorder: primaryHoverBorder ?? this.primaryHoverBorder,
      primaryDisabledBorder: primaryDisabledBorder ?? this.primaryDisabledBorder,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      secondaryHoverBorder: secondaryHoverBorder ?? this.secondaryHoverBorder,
      secondaryDisabledBorder: secondaryDisabledBorder ?? this.secondaryDisabledBorder,
      tertiaryBorder: tertiaryBorder ?? this.tertiaryBorder,
      tertiaryHoverBorder: tertiaryHoverBorder ?? this.tertiaryHoverBorder,
      tertiaryDisabledBorder: tertiaryDisabledBorder ?? this.tertiaryDisabledBorder,
    );
  }
}
