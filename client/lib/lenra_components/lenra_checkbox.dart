import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final bool disabled;
  final bool tristate;
  final Function onChanged;
  final LenraCheckboxThemeData lenraCheckboxThemeData;

  LenraCheckbox({
    Key key,
    this.label = "",
    this.value,
    this.disabled = false,
    this.tristate = false,
    this.onChanged,
    this.lenraCheckboxThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraCheckboxThemeData finalLenraCheckboxThemeData =
        LenraTheme.of(context).lenraCheckboxThemeData.merge(this.lenraCheckboxThemeData);

    Widget checkbox = Checkbox(
      value: this.value,
      onChanged: this.disabled ? null : this.onChanged ?? (e) => null,
      tristate: this.tristate,
    );
    if (this.label == null) {
      return checkbox;
    }

    return Row(
      children: [
        checkbox,
        Text(
          this.label,
          style: disabled
              ? finalLenraCheckboxThemeData.lenraTextThemeData.disabledBodyText
              : finalLenraCheckboxThemeData.lenraTextThemeData.bodyText,
        ),
      ],
    );
  }
}
