import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_toggle_syle.dart';

//TODO: move this value in Theme

class LenraToggle extends StatelessWidget {
  final LenraToggleStyle? style;
  final bool value;
  final ValueChanged<bool>? onPressed;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final DragStartBehavior dragStartBehavior;

  const LenraToggle({
    this.style,
    required this.value,
    required this.onPressed,
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
      activeColor: style?.activeColor,
      activeThumbImage: style?.activeThumbImage,
      activeTrackColor: style?.activeTrackColor,
      autofocus: autofocus,
      dragStartBehavior: dragStartBehavior,
      focusColor: style?.focusColor,
      focusNode: focusNode,
      hoverColor: style?.hoverColor,
      inactiveThumbColor: style?.inactiveThumbColor,
      inactiveThumbImage: style?.inactiveThumbImage,
      inactiveTrackColor: style?.inactiveTrackColor,
      materialTapTargetSize: style?.materialTapTargetSize,
      onActiveThumbImageError: style?.onActiveThumbImageError,
      onChanged: onPressed,
      onInactiveThumbImageError: style?.onInactiveThumbImageError,
      splashRadius: splashRadius,
    );
  }
}
