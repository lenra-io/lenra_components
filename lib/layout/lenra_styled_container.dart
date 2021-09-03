import 'package:flutter/cupertino.dart';

class LenraStyledContainer extends StatelessWidget {
  final Widget child;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final Color? backgroundColor;

  LenraStyledContainer({
    Key? key,
    required this.child,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
