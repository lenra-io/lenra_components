import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

//TODO: move this value in Theme
const double THUMB_RADIUS_RATIO = 3;
const double TRACK_WIDTH_RATIO = 5;
const double TRACK_HEIGHT_RATIO = 3;
const double THUMB_PADDING_RATIO = 0.3;

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
  late Animation _thumbAnimation;
  late AnimationController _animationController;
  late Widget _switch;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _thumbAnimation = AlignmentTween(
            begin: widget.value ? Alignment(1.0, 0.0) : Alignment(-1.0, 0.0),
            end: widget.value ? Alignment(-1.0, 0.0) : Alignment(1.0, 0.0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final LenraThemeData finalLenraThemeData = LenraTheme.of(context);

    final int thumbPadding = (finalLenraThemeData.baseSize * THUMB_PADDING_RATIO).toInt();
    final double thumbRadius = (finalLenraThemeData.baseSize * THUMB_RADIUS_RATIO) - thumbPadding;
    final double trackWidth = finalLenraThemeData.baseSize * TRACK_WIDTH_RATIO;
    final double trackHeight = finalLenraThemeData.baseSize * TRACK_HEIGHT_RATIO;

    _switch = Container(
      width: trackWidth,
      height: trackHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(finalLenraThemeData.baseSize * thumbRadius),
          color: widget.disabled
              ? widget.disabledColor
              : _thumbAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor),
      child: Row(
        children: [
          _thumbAnimation.value == Alignment.centerRight
              ? SizedBox(
                  width: trackWidth - thumbRadius - thumbPadding,
                )
              : SizedBox(
                  width: thumbPadding.toDouble(),
                ),
          Align(
            alignment: _thumbAnimation.value,
            child: Container(
              width: thumbRadius,
              height: thumbRadius,
              decoration: BoxDecoration(shape: BoxShape.circle, color: LenraColorThemeData.LENRA_WHITE),
            ),
          ),
          _thumbAnimation.value == Alignment.centerLeft
              ? SizedBox(
                  //calculate this size with the track and thumb size
                  width: trackWidth - thumbRadius - thumbPadding,
                )
              : SizedBox(
                  width: thumbPadding.toDouble(),
                ),
        ],
      ),
    );
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.disabled
              ? () {}
              : () {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
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
                    _switch,
                  ],
                )
              : _switch,
        );
      },
    );
  }
}
