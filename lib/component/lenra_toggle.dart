import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

//TODO: move this value in Theme
const double THUMB_RADIUS_RATIO = 3;
const double TRACK_WIDTH_RATIO = 5;
const double TRACK_HEIGHT_RATIO = 3;
const double THUMB_PADDING_RATIO = 0.2;

class LenraToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color disabledColor;
  final String? label;
  final Color labelColor;
  final bool disabled;

  const LenraToggle({
    required this.value,
    required this.onChanged,
    this.activeColor = LenraColorThemeData.LENRA_CUSTOM_GREEN,
    this.inactiveColor = LenraColorThemeData.LENRA_DISABLED_GRAY,
    this.disabledColor = LenraColorThemeData.LENRA_DISABLED_GRAY,
    this.label,
    this.labelColor = LenraColorThemeData.LENRA_BLACK,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  _LenraToggleState createState() => _LenraToggleState();
}

class _LenraToggleState extends State<LenraToggle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(LenraToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.disabled
            ? () {}
            : () {
                widget.value ? widget.onChanged(false) : widget.onChanged(true);
              },
        child: widget.label != null
            ? LenraRow(
                children: [
                  Text(
                    widget.label!,
                    style: TextStyle(
                      color: widget.labelColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                  LenraSwitch(animation: animation, toggle: widget),
                ],
              )
            : LenraSwitch(animation: animation, toggle: widget),
      ),
    );
  }
}

class LenraSwitch extends AnimatedWidget {
  final LenraToggle toggle;
  final Animation<double> animation;

  const LenraSwitch({
    Key? key,
    required this.animation,
    required this.toggle,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData finalLenraThemeData = LenraTheme.of(context);

    final int thumbPadding = (finalLenraThemeData.baseSize * THUMB_PADDING_RATIO).toInt();
    final double thumbRadius = (finalLenraThemeData.baseSize * THUMB_RADIUS_RATIO) - thumbPadding;
    final double trackWidth = finalLenraThemeData.baseSize * TRACK_WIDTH_RATIO;
    final double trackHeight = finalLenraThemeData.baseSize * TRACK_HEIGHT_RATIO;
    final ColorTween colorTween = ColorTween(begin: toggle.inactiveColor, end: toggle.activeColor);
    final AlignmentTween alignTween = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight);

    return Container(
      width: trackWidth,
      height: trackHeight,
      padding: EdgeInsets.only(left: thumbPadding.toDouble(), right: thumbPadding.toDouble()),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(finalLenraThemeData.baseSize * thumbRadius),
          color: toggle.disabled ? toggle.disabledColor : colorTween.evaluate(this.animation)),
      child: Align(
        alignment: alignTween.evaluate(animation),
        child: Container(
          width: thumbRadius,
          height: thumbRadius,
          decoration: BoxDecoration(shape: BoxShape.circle, color: LenraColorThemeData.LENRA_WHITE),
        ),
      ),
    );
  }
}
