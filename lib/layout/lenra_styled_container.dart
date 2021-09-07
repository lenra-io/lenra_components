import 'package:flutter/cupertino.dart';

class LenraStyledContainer extends StatelessWidget {
  final Widget child;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final Color? color;

  LenraStyledContainer({
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
      child: this.child,
      decoration: BoxDecoration(
        color: this.color,
        border: this.border,
        borderRadius: this.borderRadius,
        boxShadow: this.boxShadow != null ? [this.boxShadow!] : null,
      ),
    );
  }
}
