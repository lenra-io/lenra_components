import 'package:flutter/widgets.dart';

class LenraText extends StatelessWidget {
  final String text;
  final List<TextSpan>? children;
  final TextStyle? style;
  final Locale? locale;
  final String? semanticsLabel;
  final bool? spellOut;

  const LenraText({
    Key? key,
    required this.text,
    this.children,
    this.style,
    this.locale,
    this.semanticsLabel,
    this.spellOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: text,
          children: children,
          style: style,
          locale: locale,
          semanticsLabel: semanticsLabel,
          spellOut: spellOut),
    );
  }
}
