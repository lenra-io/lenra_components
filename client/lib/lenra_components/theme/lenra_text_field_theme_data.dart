import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

class LenraTextFieldThemeData {
  Map<LenraComponentSize, EdgeInsets> paddingMap;
  LenraThemeData lenraTheme;

  LenraTextFieldThemeData({
    this.lenraTheme,
    this.paddingMap,
  });
  InputDecoration getInputdecoration(LenraComponentSize size, bool disabled, String hintText, bool error, bool obscure,
      Function onSuffixPressed, String errorMessage) {
    return InputDecoration(
      contentPadding: paddingMap[size],
      isDense: true,
      filled: false,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY),
      ),
      fillColor: (disabled) ? Colors.transparent : LenraColorThemeData.LENRA_DISABLED_GRAY,
      hoverColor: (disabled) ? Colors.transparent : LenraColorThemeData.LENRA_DISABLED_GRAY,
      enabledBorder: OutlineInputBorder(
        borderSide: lenraTheme.lenraBorderThemeData.primaryBorder,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: lenraTheme.lenraBorderThemeData.primaryHoverBorder,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: lenraTheme.lenraBorderThemeData.secondaryBorder,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: lenraTheme.lenraBorderThemeData.secondaryBorder,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: lenraTheme.lenraBorderThemeData.primaryBorder,
      ),
      hintText: hintText,
      hintStyle: lenraTheme.lenraTextThemeData.disabledBodyText,
      errorText: (error) ? errorMessage : null,
      errorStyle: lenraTheme.lenraTextThemeData.errorText,
      suffixIcon: (onSuffixPressed != null)
          ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              ),
              color: lenraTheme.lenraBorderThemeData.primaryBorder.color,
              onPressed: () {
                onSuffixPressed();
              },
            )
          : null,
    );
  }

  TextStyle getLabelStyle() {
    return lenraTheme.lenraTextThemeData.bodyText;
  }

  TextStyle getDescriptionStyle() {
    return lenraTheme.lenraTextThemeData.disabledBodyText;
  }
}
