import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_text_field_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

enum LenraTextFieldSize {
  Small,
  Medium,
  Large,
}

class LenraTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final String description;
  final bool obscure;
  final Function checkError;
  final bool disabled;
  final LenraTextFieldSize size;
  final bool inRow;
  final String errorMessage;
  @override
  final GlobalKey<_LenraTextField> key = new GlobalKey<_LenraTextField>();

  LenraTextField({
    this.label,
    this.hintText,
    this.description,
    this.obscure,
    this.checkError,
    this.disabled,
    this.size,
    this.inRow,
    this.errorMessage,
  });

  @override
  _LenraTextField createState() {
    return _LenraTextField(
      label: this.label,
      hintText: this.hintText,
      description: this.description,
      obscure: (this.obscure != null) ? this.obscure : false,
      checkError: this.checkError,
      disabled: (this.disabled != null) ? !this.disabled : true,
      size: this.size,
      inRow: (this.inRow != null) ? this.inRow : false,
      errorMessage: (this.errorMessage != null) ? this.errorMessage : "",
    );
  }
}

class _LenraTextField extends State<LenraTextField> {
  final String label;
  final String hintText;
  final String description;
  final bool obscure;
  final Function checkError;
  final bool disabled;
  final LenraTextFieldSize size;
  final double width = 200.0;
  final bool inRow;
  final String errorMessage;
  Function refreshBorder;
  LenraTextFieldThemeData lenraTextFieldThemeData;
  FocusNode myFocusNode;
  String value = "";
  bool error = false;

  _LenraTextField({
    this.label,
    this.hintText,
    this.description,
    this.obscure,
    this.checkError,
    this.disabled,
    this.size,
    this.inRow,
    this.errorMessage,
  });

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  String getValue() {
    return value;
  }

  void setError(bool value) {
    setState(() {
      this.error = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LenraTextFieldThemeData lenraTextFieldThemeData = LenraTheme.of(context).lenraTextFieldThemeData;

    Container textField = Container(
      width: this.width,
      child: TextField(
        enabled: this.disabled,
        obscureText: this.obscure,
        style: TextStyle(
          fontSize: lenraTextFieldThemeData.fontSize.resolve(this.size).height,
        ),
        focusNode: myFocusNode,
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
        onChanged: (String newValue) {
          setState(() {
            this.value = newValue;
            this.error = (checkError != null) ? this.checkError(value) : this.error;
          });
        },
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
