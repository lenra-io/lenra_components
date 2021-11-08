import 'package:flutter/widgets.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

class LenraContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;

  const LenraContainer({
    Key? key,
    required this.child,
    this.padding,
    this.constraints,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);

    return Container(
      child: child,
      padding: padding != null ? padding! * theme.baseSize : padding,
      constraints: constraints,
      decoration: decoration,
    );
  }
}
