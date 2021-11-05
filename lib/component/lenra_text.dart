import 'package:flutter/widgets.dart';

class LenraText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<TextSpan>? children;
  final Locale? locale;
  final String? semanticsLabel;
  final bool? spellOut;

  const LenraText({
    this.children,
    this.locale,
    required this.text,
    this.style,
    this.semanticsLabel,
    this.spellOut,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        children: children,
        text: text,
        locale: locale,
        style: style,
        semanticsLabel: semanticsLabel,
        spellOut: spellOut));
  }
}
