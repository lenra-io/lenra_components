import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_toggle_theme_data.dart';

class LenraToggle extends StatelessWidget {
  final bool value;
  late final bool disabled;
  final Function(bool) onChanged;
  final String? label;

  LenraToggle({
    required this.value,
    required this.onChanged,
    this.disabled = false,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraToggleThemeData finalLenraToggleThemeData =
        LenraTheme.of(context).lenraToggleThemeData;
    List<Widget> children = [];

    if (label != null)
      children.add(Text(
        label!,
        textAlign: TextAlign.right,
      ));
    children.add(
      Switch(
        value: this.disabled ? true : this.value,
        onChanged: (bool _value) {
          if (!this.disabled) this.onChanged(_value);
        },
        activeColor: finalLenraToggleThemeData.get_activeColor(this.disabled),
        thumbColor: MaterialStateProperty.all(LenraColorThemeData.LENRA_WHITE),
      ),
    );
    return LenraRow(children: children);
  }
}
