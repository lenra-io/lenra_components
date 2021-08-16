import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

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
    List<Widget> children = [];

    if (label != null)
      children.add(Text(
        label!,
        textAlign: TextAlign.right,
      ));
    children.add(
      SizedBox(
        height: 24,
        //width: 44,
        child: Switch(
          value: this.value,
          onChanged: (bool _value) {
            if (!this.disabled) this.onChanged(_value);
          },
          activeColor: this.disabled ? LenraColorThemeData.LENRA_DISABLED_GRAY : LenraColorThemeData.LENRA_WHITE,
          activeTrackColor:
              this.disabled ? LenraColorThemeData.LENRA_DISABLED_GRAY : LenraColorThemeData.LENRA_CUSTOM_GREEN,
        ),
      ),
    );
    if (children.length > 1) {
      return LenraRow(children: children);
    } else {
      return children.first;
    }
  }
}
