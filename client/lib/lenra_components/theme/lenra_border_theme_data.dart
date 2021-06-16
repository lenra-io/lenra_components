import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

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
    BorderSide? tertiaryBorder,
    BorderSide? tertiaryHoverBorder,
    BorderSide? tertiaryDisabledBorder,
    BorderSide? errorBorder,
  }) {
    /* TODO: set default value for all border*/
    this.borderRadius = borderRadius ?? BorderRadius.circular(4.0);
    this.primaryBorder = primaryBorder ?? BorderSide(color: Colors.grey);
    this.primaryHoverBorder = primaryHoverBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE);
    this.primaryDisabledBorder = primaryDisabledBorder ?? BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY);
    this.secondaryBorder = secondaryBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE);
    this.secondaryHoverBorder = secondaryHoverBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE);
    this.secondaryDisabledBorder =
        secondaryDisabledBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE_UNAVAILABLE);
    this.tertiaryBorder = tertiaryBorder;
    this.tertiaryHoverBorder = tertiaryHoverBorder;
    this.tertiaryDisabledBorder = tertiaryDisabledBorder;
    this.errorBorder = errorBorder ?? BorderSide(color: LenraColorThemeData.LENRA_CUSTOM_RED);
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
