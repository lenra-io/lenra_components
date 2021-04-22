import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraCheckbox extends StatefulWidget {
  final String text;
  final bool value;
  final bool disabled;
  final bool tristate;
  final Function onChanged;
  final LenraCheckboxThemeData lenraCheckboxThemeData;

  LenraCheckbox({
    Key key,
    this.text = "",
    this.value,
    this.disabled = false,
    this.tristate = false,
    this.onChanged,
    this.lenraCheckboxThemeData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LenraCheckbox(
        value: this.value,
        disabled: this.disabled,
        tristate: this.tristate,
        lenraCheckboxThemeData: this.lenraCheckboxThemeData,
      );
}

class _LenraCheckbox extends State<LenraCheckbox> {
  bool _isChecked = false;
  bool disabled = false;
  bool tristate = false;
  LenraCheckboxThemeData lenraCheckboxThemeData;

  _LenraCheckbox({bool value, bool disabled, bool tristate, LenraCheckboxThemeData lenraCheckboxThemeData}) {
    this._isChecked = value;
    this.disabled = disabled;
    this.tristate = tristate;
    this.lenraCheckboxThemeData = lenraCheckboxThemeData;
  }

  @override
  Widget build(BuildContext context) {
    final LenraCheckboxThemeData finalLenraCheckboxThemeData =
        LenraTheme.of(context).lenraCheckboxThemeData.merge(this.lenraCheckboxThemeData);

    Function(bool) onChanged = widget.onChanged == null || this.disabled
        ? null
        : (value) {
            setState(() {
              if (_isChecked == false) {
                _isChecked = true;
              } else if (_isChecked == true) {
                if (this.tristate)
                  _isChecked = null;
                else
                  _isChecked = false;
              } else if (_isChecked == null) {
                _isChecked = false;
              }
              widget.onChanged(_isChecked);
            });
          };

    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: onChanged,
          tristate: this.tristate,
        ),
        if (widget.text != null)
          Text(
            widget.text,
            style: disabled
                ? finalLenraCheckboxThemeData.lenraTextThemeData.disabledBodyText
                : finalLenraCheckboxThemeData.lenraTextThemeData.bodyText,
          ),
      ],
    );
  }
}
