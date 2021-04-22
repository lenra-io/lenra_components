import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

class LenraBorderThemeData {
  BorderSide primaryBorder;
  BorderSide primaryHoverBorder;
  BorderSide primaryDisabledBorder;

  BorderSide secondaryBorder;
  BorderSide secondaryHoverBorder;
  BorderSide secondaryDisabledBorder;

  BorderSide tertiaryBorder;
  BorderSide tertiaryHoverBorder;
  BorderSide tertiaryDisabledBorder;

  LenraBorderThemeData({
    BorderSide primaryBorder,
    BorderSide primaryHoverBorder,
    BorderSide primaryDisabledBorder,
    BorderSide secondaryBorder,
    BorderSide secondaryHoverBorder,
    BorderSide secondaryDisabledBorder,
    BorderSide tertiaryBorder,
    BorderSide tertiaryHoverBorder,
    BorderSide tertiaryDisabledBorder,
  }) {
    this.primaryBorder = primaryBorder ?? null;
    this.primaryHoverBorder = primaryHoverBorder ?? null;
    this.primaryDisabledBorder = primaryDisabledBorder ?? null;
    this.secondaryBorder = secondaryBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE);
    this.secondaryHoverBorder = secondaryHoverBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE);
    this.secondaryDisabledBorder =
        secondaryDisabledBorder ?? BorderSide(color: LenraColorThemeData.LENRA_BLUE_UNAVAILABLE);
    this.tertiaryBorder = tertiaryBorder ?? null;
    this.tertiaryHoverBorder = tertiaryHoverBorder ?? null;
    this.tertiaryDisabledBorder = tertiaryDisabledBorder ?? null;
  }

  LenraBorderThemeData merge(LenraBorderThemeData incoming) {
    if (incoming != null) {
      return LenraBorderThemeData(
        primaryBorder: this.primaryBorder == null
            ? incoming.primaryBorder
            : BorderSide.merge(this.primaryBorder, incoming.primaryBorder),
        primaryHoverBorder: this.primaryHoverBorder == null
            ? incoming.primaryHoverBorder
            : BorderSide.merge(this.primaryHoverBorder, incoming.primaryHoverBorder),
        primaryDisabledBorder: this.primaryDisabledBorder == null
            ? incoming.primaryDisabledBorder
            : BorderSide.merge(this.primaryDisabledBorder, incoming.primaryDisabledBorder),
        secondaryBorder: this.secondaryBorder == null
            ? incoming.secondaryBorder
            : BorderSide.merge(this.secondaryBorder, incoming.secondaryBorder),
        secondaryHoverBorder: this.secondaryHoverBorder == null
            ? incoming.secondaryHoverBorder
            : BorderSide.merge(this.secondaryHoverBorder, incoming.secondaryHoverBorder),
        secondaryDisabledBorder: this.secondaryDisabledBorder == null
            ? incoming.secondaryDisabledBorder
            : BorderSide.merge(this.secondaryDisabledBorder, incoming.secondaryDisabledBorder),
        tertiaryBorder: this.tertiaryBorder == null
            ? incoming.tertiaryBorder
            : BorderSide.merge(this.tertiaryBorder, incoming.tertiaryBorder),
        tertiaryHoverBorder: this.tertiaryHoverBorder == null
            ? incoming.tertiaryHoverBorder
            : BorderSide.merge(this.tertiaryHoverBorder, incoming.tertiaryHoverBorder),
        tertiaryDisabledBorder: this.tertiaryDisabledBorder == null
            ? incoming.tertiaryDisabledBorder
            : BorderSide.merge(this.tertiaryDisabledBorder, incoming.tertiaryDisabledBorder),
      );
    }

    return this;
  }
}
