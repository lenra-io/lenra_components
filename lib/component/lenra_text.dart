import 'package:flutter/widgets.dart';

class LenraText extends StatelessWidget {
  final String text;
  final List<LenraText>? children;
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

  TextSpan _toTextSpan(LenraText text) {
    return TextSpan(
      text: text.text,
      children: text.children?.map(_toTextSpan).toList(),
      style: text.style,
      locale: text.locale,
      semanticsLabel: text.semanticsLabel,
      spellOut: text.spellOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: children?.map(_toTextSpan).toList(),
        style: style,
        locale: locale,
        semanticsLabel: semanticsLabel,
        spellOut: spellOut,
      ),
    );
  }
}
