import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

//TODO: move this value in Theme
const double thumbRadiusRatio = 3;
const double trackWidthRatio = 5;
const double trackHeightRatio = 3;
const double thumbPaddingRatio = 0.25;

class LenraToggle extends StatefulWidget {
  final bool value;
  final Function() onPressed;
  final Color activeColor = LenraColorThemeData.lenraFunGreenBase;
  final Color inactiveColor = LenraColorThemeData.greyNature;
  final Color disabledColor = LenraColorThemeData.greyLight;
  final String? label;
  final Color labelColor = LenraColorThemeData.blackMoon;
  final Color disabledLabelColor = LenraColorThemeData.greyNature;
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
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(LenraToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    return LenraFlex(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        color: widget.disabled ? widget.disabledLabelColor : widget.labelColor,
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

    final int thumbPadding = (finalLenraThemeData.baseSize * thumbPaddingRatio).toInt();
    final double thumbRadius = (finalLenraThemeData.baseSize * thumbRadiusRatio) - thumbPadding * 2;
    final double trackWidth = finalLenraThemeData.baseSize * trackWidthRatio;
    final double trackHeight = finalLenraThemeData.baseSize * trackHeightRatio;
    final ColorTween colorTween = ColorTween(begin: toggle.inactiveColor, end: toggle.activeColor);
    final AlignmentTween alignTween = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight);

    return Container(
      width: trackWidth,
      height: trackHeight,
      padding: EdgeInsets.only(left: thumbPadding.toDouble(), right: thumbPadding.toDouble()),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(trackHeight / 2),
          color: toggle.disabled ? toggle.disabledColor : colorTween.evaluate(animation)),
      child: Align(
        alignment: alignTween.evaluate(animation),
        child: Container(
          width: thumbRadius,
          height: thumbRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LenraColorThemeData.lenraWhite,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2.0),
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
