import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

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
  InputDecoration getInputdecoration(LenraComponentSize size, bool disabled, String? hintText, bool error, bool obscure,
      void Function()? onSuffixPressed, String? errorMessage) {
    return InputDecoration(
      contentPadding: paddingMap[size],
      isDense: true,
      filled: false,
      border: OutlineInputBorder(
        borderSide: lenraThemeData.lenraBorderThemeData.primaryDisabledBorder,
      ),
      fillColor: (disabled) ? Colors.transparent : LenraColorThemeData.lenraDisabledGray,
      hoverColor: (disabled) ? Colors.transparent : LenraColorThemeData.lenraDisabledGray,
      enabledBorder: OutlineInputBorder(
        borderSide: enabledBorder ?? lenraThemeData.lenraBorderThemeData.primaryBorder,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: focusedBorder ?? lenraThemeData.lenraBorderThemeData.primaryHoverBorder,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: errorBorder ?? lenraThemeData.lenraBorderThemeData.errorBorder,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: focusedErrorBorder ?? lenraThemeData.lenraBorderThemeData.secondaryBorder,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: disabledBorder ?? lenraThemeData.lenraBorderThemeData.primaryBorder,
      ),
      hintText: hintText,
      hintStyle: hintTextStyle ?? lenraThemeData.lenraTextThemeData.disabledBodyText,
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
      lenraThemeData: lenraThemeData,
      paddingMap: incoming.paddingMap,
      enabledBorder: incoming.enabledBorder ?? enabledBorder,
      focusedBorder: incoming.focusedBorder ?? focusedBorder,
      errorBorder: incoming.errorBorder ?? errorBorder,
      focusedErrorBorder: incoming.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: incoming.disabledBorder ?? disabledBorder,
      errorTextStyle: incoming.errorTextStyle ?? errorTextStyle,
      hintTextStyle: incoming.hintTextStyle ?? hintTextStyle,
    );
  }
}
