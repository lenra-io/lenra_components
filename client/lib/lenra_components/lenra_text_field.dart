import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

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

    Container textField = Container(
      width: this.width,
      child: TextField(
        enabled: !this.disabled,
        obscureText: this.obscure,
        style: TextStyle(
          fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height,
        ),
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: (this.disabled) ? Colors.transparent : Colors.grey[200],
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
            fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height,
          ),
          contentPadding: EdgeInsets.fromLTRB(
            5.0,
            lenraTextFieldThemeData.fontSize.resolve(this.size).height,
            5.0,
            lenraTextFieldThemeData.fontSize.resolve(this.size).height,
          ),
          errorText: (this.error) ? this.errorMessage : null,
          errorStyle: TextStyle(fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height),
        ),
        onEditingComplete: this.disabled ? null : this.onEditingComplete,
        onSubmitted: this.onSubmitted,
        onChanged: this.onChanged,
      ),
    );

    if (inRow) {
      return Row(
        children: [
          Text(
            (this.label != null) ? this.label : "",
            style: TextStyle(fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height),
            textAlign: TextAlign.left,
          ),
          textField,
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            width: this.width,
            child: Text(
              (this.label != null) ? this.label : "",
              style: TextStyle(fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height),
              textAlign: TextAlign.left,
            ),
          ),
          textField,
          if (!this.error)
            SizedBox(
              width: this.width,
              child: Text(
                (this.description != null) ? this.description : "",
                style: TextStyle(
                  fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height,
                ),
                textAlign: TextAlign.left,
              ),
            ),
        ],
      );
    }
  }
}
