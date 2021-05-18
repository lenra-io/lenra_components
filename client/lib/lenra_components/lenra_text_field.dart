import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

import 'theme/lenra_text_field_theme_data.dart';

enum LenraTextFieldSize {
  Small,
  Medium,
  Large,
}

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
  final LenraTextFieldSize size;
  final double width;
  final FocusNode focusNode;
  final TextEditingController controller;

  LenraTextField({
    this.label,
    this.hintText,
    this.description,
    this.errorMessage,
    this.obscure = false,
    this.disabled = false,
    this.inRow = false,
    this.error = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.size = LenraTextFieldSize.Medium,
    this.width = 200.0,
    this.focusNode,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final LenraTextFieldThemeData lenraTextFieldThemeData = LenraTheme.of(context).lenraTextFieldThemeData;

    Container textField = this.buildTextField(
      context,
      lenraTextFieldThemeData,
    );

    if (inRow) {
      return this.buildRowStyle(context, textField, lenraTextFieldThemeData);
    } else {
      return this.buildColumnStyle(context, textField, lenraTextFieldThemeData);
    }
  }

  Widget buildTextField(BuildContext context, LenraTextFieldThemeData lenraTextFieldThemeData) {
    Color backgroundColor = (this.disabled) ? Colors.transparent : Colors.grey[200];
    return Container(
      width: this.width,
      child: TextField(
        enabled: !this.disabled,
        obscureText: this.obscure,
        style: TextStyle(
          fontSize: lenraTextFieldThemeData.fontSize,
        ),
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
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
          hintText: this.hintText ?? "",
          hintStyle: TextStyle(
            fontSize: lenraTextFieldThemeData.fontSize,
          ),
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(
            5.0,
            // TODO not clean like this ?
            lenraTextFieldThemeData.height.resolve(this.size) / 2,
            5.0,
            lenraTextFieldThemeData.height.resolve(this.size) / 2,
          ),
          errorText: (this.error) ? this.errorMessage : null,
          errorStyle: TextStyle(fontSize: lenraTextFieldThemeData.fontSize),
        ),
        onEditingComplete: this.disabled ? null : this.onEditingComplete ?? () => null,
        onSubmitted: this.onSubmitted,
        onChanged: this.onChanged,
      ),
    );
  }

  Widget buildRowStyle(BuildContext context, Widget textField, LenraTextFieldThemeData lenraTextFieldThemeData) {
    return Row(
      children: [
        Text(
          (this.label != null) ? this.label : "",
          style: TextStyle(fontSize: lenraTextFieldThemeData.fontSize),
          textAlign: TextAlign.left,
        ),
        textField,
      ],
    );
  }

  Widget buildColumnStyle(BuildContext context, Widget textField, LenraTextFieldThemeData lenraTextFieldThemeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TextInfo(
          fontSize: lenraTextFieldThemeData.fontSize,
          text: this.label,
        ),
        textField,
        if (!this.error && this.description != null) ...[
          // TODO change height to sizeFactor from Theme
          SizedBox(height: 4.0),
          _TextInfo(
            // TODO Change fontSize to Theme
            fontSize: 12.0,
            textColor: lenraTextFieldThemeData.descriptionColor,
            text: this.description,
          ),
        ]
      ],
    );
  }
}

class _TextInfo extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  _TextInfo({this.text, this.fontSize, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: this.fontSize,
        color: this.textColor,
      ),
    );
  }
}
