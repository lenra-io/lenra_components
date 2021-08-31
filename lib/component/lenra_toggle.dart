import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

//TODO: move this value in Theme
const double THUMB_RADIUS_RATIO = 3;
const double TRACK_WIDTH_RATIO = 5;
const double TRACK_HEIGHT_RATIO = 3;
const double THUMB_PADDING_RATIO = 0.25;

class LenraToggle extends StatefulWidget {
  final bool value;
  final Function() onPressed;
  final Color activeColor = LenraColorThemeData.LENRA_FUN_GREEN_BASE;
  final Color inactiveColor = LenraColorThemeData.GREY_NATURE;
  final Color disabledColor = LenraColorThemeData.GREY_LIGHT;
  final String? label;
  final Color labelColor = LenraColorThemeData.BLACK_MOON;
  final bool disabled;

  const LenraToggle({
    required this.value,
    required this.onPressed,
    this.label,
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
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
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
      if (widget.value) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.disabled ? _buildWidget() : _buildInteractiveWidget();
  }

  Widget _buildInteractiveWidget() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    var lenraSwitch = _LenraSwitch(animation: animation, toggle: widget);
    if (widget.label == null) return lenraSwitch;
    return LenraRow(
      children: [
        _buildLabel(),
        lenraSwitch,
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label!,
      style: TextStyle(
        color: widget.labelColor,
        fontWeight: FontWeight.w400,
        fontSize: 15.0,
      ),
    );
  }
}

class _LenraSwitch extends AnimatedWidget {
  final LenraToggle toggle;
  final Animation<double> animation;

  const _LenraSwitch({
    Key? key,
    required this.animation,
    required this.toggle,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData finalLenraThemeData = LenraTheme.of(context);

    final int thumbPadding = (finalLenraThemeData.baseSize * THUMB_PADDING_RATIO).toInt();
    final double thumbRadius = (finalLenraThemeData.baseSize * THUMB_RADIUS_RATIO) - thumbPadding * 2;
    final double trackWidth = finalLenraThemeData.baseSize * TRACK_WIDTH_RATIO;
    final double trackHeight = finalLenraThemeData.baseSize * TRACK_HEIGHT_RATIO;
    final ColorTween colorTween = ColorTween(begin: toggle.inactiveColor, end: toggle.activeColor);
    final AlignmentTween alignTween = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight);

    return Container(
      width: trackWidth,
      height: trackHeight,
      padding: EdgeInsets.only(left: thumbPadding.toDouble(), right: thumbPadding.toDouble()),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(trackHeight / 2),
          color: toggle.disabled ? toggle.disabledColor : colorTween.evaluate(this.animation)),
      child: Align(
        alignment: alignTween.evaluate(animation),
        child: Container(
          width: thumbRadius,
          height: thumbRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LenraColorThemeData.LENRA_WHITE,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
                color: Colors.black.withOpacity(0.16),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
