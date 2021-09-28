import 'package:flutter/cupertino.dart';

class LenraStyledContainer extends StatelessWidget {
  final Widget child;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final Color? color;

  const LenraStyledContainer({
    Key? key,
    required this.child,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
      ),
    );
  }
}
