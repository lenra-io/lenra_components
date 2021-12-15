import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_toggle_style.dart';

class LenraToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onPressed;
  final LenraToggleStyle? style;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final DragStartBehavior dragStartBehavior;

  const LenraToggle({
    required this.value,
    required this.onPressed,
    this.style,
    this.splashRadius,
    this.autofocus = true,
    this.focusNode,
    this.dragStartBehavior = DragStartBehavior.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onPressed,
      activeColor: style?.activeColor,
      activeThumbImage: style?.activeThumbImage,
      activeTrackColor: style?.activeTrackColor,
      focusColor: style?.focusColor,
      hoverColor: style?.hoverColor,
      inactiveThumbColor: style?.inactiveThumbColor,
      inactiveThumbImage: style?.inactiveThumbImage,
      inactiveTrackColor: style?.inactiveTrackColor,
      materialTapTargetSize: style?.materialTapTargetSize,
      onActiveThumbImageError: style?.onActiveThumbImageError,
      onInactiveThumbImageError: style?.onInactiveThumbImageError,
      splashRadius: splashRadius,
      autofocus: autofocus,
      focusNode: focusNode,
      dragStartBehavior: dragStartBehavior,
    );
  }
}
