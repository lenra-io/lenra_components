import 'package:flutter/widgets.dart';

class LenraStack extends StatelessWidget {
  final List<Widget> children;
  final AlignmentGeometry? alignment;
  final StackFit? fit;

  const LenraStack({
    Key? key,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.fit = StackFit.loose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children,
      alignment: alignment ?? AlignmentDirectional.topStart,
      fit: fit ?? StackFit.loose,
    );
  }
}
