import 'package:flutter/widgets.dart';

class LenraStack extends StatelessWidget {
  final List<Widget> children;
  final AlignmentGeometry? alignment;
  final StackFit? fit;
  final TextDirection? textDirection;

  const LenraStack({
    Key? key,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.fit = StackFit.loose,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children,
      alignment: alignment ?? AlignmentDirectional.topStart,
      fit: fit ?? StackFit.loose,
      textDirection: textDirection,
    );
  }
}
