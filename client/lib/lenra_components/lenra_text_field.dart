import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

// ignore: must_be_immutable
class LenraTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String description;
  final String errorMessage;
  final bool obscure;
  final bool disabled;
  final bool inRow;
  final bool error;
  final Function onEditingComplete;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final LenraComponentSize size;
  final Function onSuffixPressed;
  final double width;
  final FocusNode focusNode;
  final TextEditingController controller;

  LenraTextField({
    this.label = "",
    this.hintText = "",
    this.description = "",
    this.errorMessage,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.error = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.size = LenraComponentSize.Medium,
    this.width = double.infinity,
    this.onSuffixPressed,
    this.focusNode,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LenraTheme.of(context);
    final LenraTextFieldThemeData lenraTextFieldThemeData = theme.lenraTextFieldThemeData;

    Text labelWidget = (this.label == null || this.label.isEmpty)
        ? null
        : Text(
            this.label,
            style: lenraTextFieldThemeData.textStyle,
            textAlign: TextAlign.left,
          );
    Widget textField = this.buildTextField(
      context,
      lenraTextFieldThemeData,
    );

    List<Widget> colChildren = [];

    if (inRow && labelWidget != null) {
      colChildren.add(LenraRow(
        separationFactor: 2,
        children: [
          labelWidget,
          Expanded(child: textField),
        ],
      ));
    } else {
      if (labelWidget != null) colChildren.add(labelWidget);
      colChildren.add(textField);
    }
    if (this.description != null && this.description.isNotEmpty && !this.error) {
      colChildren.add(Text(
        this.description,
        style: lenraTextFieldThemeData.descriptionStyle,
        textAlign: TextAlign.left,
      ));
    }
    if (colChildren.length > 1) {
      textField = LenraColumn(
        separationFactor: 0.5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: colChildren,
      );
    }
    return SizedBox(
      width: width != null && width > 0 && width != double.infinity ? width : double.infinity,
      child: textField,
    );
  }

  Widget buildTextField(BuildContext context, LenraTextFieldThemeData lenraTextFieldThemeData) {
    Color backgroundColor = (this.disabled) ? Colors.transparent : Colors.grey[200];

    var padding = lenraTextFieldThemeData.paddingMap[size];
    var border = BorderSide(color: LenraColorThemeData.LENRA_DISABLED_GRAY);

    padding = EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
      left: padding.left,
      right: padding.right,
    );

    // TODO: gérer les erreurs

    var inputDecoration = InputDecoration(
      contentPadding: padding,
      isDense: true,
      filled: false,
      border: OutlineInputBorder(
        borderSide: border,
      ),
      fillColor: backgroundColor,
      hoverColor: backgroundColor,
      enabledBorder: OutlineInputBorder(
        borderSide: lenraTextFieldThemeData.border.primaryBorder,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: lenraTextFieldThemeData.border.primaryHoverBorder,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: lenraTextFieldThemeData.border.secondaryBorder,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: lenraTextFieldThemeData.border.secondaryBorder,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: lenraTextFieldThemeData.border.primaryBorder,
      ),
      hintText: this.hintText,
      hintStyle: lenraTextFieldThemeData.hintTextStyle,
      errorText: (this.error) ? this.errorMessage : null,
      errorStyle: lenraTextFieldThemeData.textTheme.errorText,
      suffixIcon: (this.onSuffixPressed != null)
          ? IconButton(
              icon: Icon(
                this.obscure ? Icons.visibility_off : Icons.visibility,
              ),
              color: lenraTextFieldThemeData.border.primaryBorder.color,
              onPressed: () {
                this.onSuffixPressed();
              },
            )
          : null,
    );

    return TextField(
      enabled: !this.disabled,
      obscureText: this.obscure,
      style: lenraTextFieldThemeData.textStyle,
      strutStyle: StrutStyle(
        leading: 0.15,
      ),
      controller: controller,
      focusNode: focusNode,
      decoration: inputDecoration,
      onEditingComplete: this.disabled ? null : this.onEditingComplete,
      onSubmitted: this.onSubmitted,
      onChanged: this.onChanged,
    );
  }
}
