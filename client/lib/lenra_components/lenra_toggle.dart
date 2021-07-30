import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_color_theme_data.dart';

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
        width: 44,
        child: CupertinoSwitch(
          value: this.disabled ? true : this.value,
          onChanged: (bool _value) {
            if (!this.disabled) this.onChanged(_value);
          },
          activeColor: this.disabled
              ? LenraColorThemeData.LENRA_DISABLED_GRAY
              : LenraColorThemeData.LENRA_CUSTOM_GREEN,
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
