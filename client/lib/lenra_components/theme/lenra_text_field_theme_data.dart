import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraTextFieldThemeData {
  final Map<LenraComponentSize, EdgeInsets> paddingMap;
  final LenraThemeData lenraThemeData;
  final BorderSide? enabledBorder;
  final BorderSide? focusedBorder;
  final BorderSide? errorBorder;
  final BorderSide? focusedErrorBorder;
  final BorderSide? disabledBorder;
  final TextStyle? hintTextStyle;
  final TextStyle? errorTextStyle;

  LenraTextFieldThemeData({
    required this.lenraThemeData,
    required this.paddingMap,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.errorTextStyle,
    this.hintTextStyle,
  });
  InputDecoration getInputdecoration(
      LenraComponentSize size,
      bool disabled,
      String? hintText,
      bool error,
      bool obscure,
      void Function()? onSuffixPressed,
      String? errorMessage) {
    return InputDecoration(
      contentPadding: paddingMap[size],
      isDense: true,
      filled: false,
      border: OutlineInputBorder(
        borderSide: lenraThemeData.lenraBorderThemeData.primaryDisabledBorder,
      ),
      fillColor: (disabled)
          ? Colors.transparent
          : LenraColorThemeData.LENRA_DISABLED_GRAY,
      hoverColor: (disabled)
          ? Colors.transparent
          : LenraColorThemeData.LENRA_DISABLED_GRAY,
      enabledBorder: OutlineInputBorder(
        borderSide:
            enabledBorder ?? lenraThemeData.lenraBorderThemeData.primaryBorder,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: focusedBorder ??
            lenraThemeData.lenraBorderThemeData.primaryHoverBorder,
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            errorBorder ?? lenraThemeData.lenraBorderThemeData.errorBorder,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: focusedErrorBorder ??
            lenraThemeData.lenraBorderThemeData.secondaryBorder,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide:
            disabledBorder ?? lenraThemeData.lenraBorderThemeData.primaryBorder,
      ),
      hintText: hintText,
      hintStyle:
          hintTextStyle ?? lenraThemeData.lenraTextThemeData.disabledBodyText,
      errorText: (error) ? errorMessage : null,
      errorStyle: errorTextStyle ?? lenraThemeData.lenraTextThemeData.errorText,
      suffixIcon: (onSuffixPressed != null)
          ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              ),
              color: lenraThemeData.lenraBorderThemeData.primaryBorder.color,
              onPressed: () {
                onSuffixPressed();
              },
            )
          : null,
    );
  }

  TextStyle getLabelStyle() {
    return lenraThemeData.lenraTextThemeData.bodyText;
  }

  TextStyle getDescriptionStyle() {
    return lenraThemeData.lenraTextThemeData.disabledBodyText;
  }

  LenraTextFieldThemeData copyWith(LenraTextFieldThemeData incoming) {
    return LenraTextFieldThemeData(
      lenraThemeData: this.lenraThemeData,
      paddingMap: incoming.paddingMap,
      enabledBorder: incoming.enabledBorder ?? this.enabledBorder,
      focusedBorder: incoming.focusedBorder ?? this.focusedBorder,
      errorBorder: incoming.errorBorder ?? this.errorBorder,
      focusedErrorBorder:
          incoming.focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder: incoming.disabledBorder ?? this.disabledBorder,
      errorTextStyle: incoming.errorTextStyle ?? this.errorTextStyle,
      hintTextStyle: incoming.hintTextStyle ?? this.hintTextStyle,
    );
  }
}
