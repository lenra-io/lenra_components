import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';

class LenraToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String? label;
  final Color labelColor;
  final bool disabled;

  const LenraToggle({
    required this.value,
    required this.onChanged,
    this.activeColor = LenraColorThemeData.LENRA_CUSTOM_GREEN,
    this.inactiveColor = LenraColorThemeData.LENRA_DISABLED_GRAY,
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
    _switch = Container(
      width: 44.0,
      height: 24.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: widget.disabled
              ? LenraColorThemeData.LENRA_DISABLED_GRAY
              : _thumbAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor),
      child: Row(
        children: [
          _thumbAnimation.value == Alignment.centerRight
              ? Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                ),
          Align(
            alignment: _thumbAnimation.value,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: LenraColorThemeData.LENRA_WHITE),
            ),
          ),
          _thumbAnimation.value == Alignment.centerLeft
              ? Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
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
