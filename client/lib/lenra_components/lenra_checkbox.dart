import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_checkbox_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';

class LenraCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final bool disabled;
  final Function onChanged;

  LenraCheckbox({
    Key key,
    this.label = "",
    this.value = false,
    this.disabled = false,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraCheckboxThemeData finalLenraCheckboxThemeData = LenraTheme.of(context).lenraCheckboxThemeData;

    Widget checkbox = Checkbox(
      value: this.value,
      onChanged: this.disabled ? () {} : this.onChanged ?? (e) => null,
      tristate: true,
    );
    if (this.label == null) {
      return checkbox;
    }

    return Row(
      children: [
        checkbox,
        Text(
          this.label,
          style: finalLenraCheckboxThemeData.getTextStyle(disabled),
        ),
      ],
    );
  }
}
