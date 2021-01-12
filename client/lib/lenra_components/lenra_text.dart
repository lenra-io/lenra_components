import 'package:flutter/material.dart';
import 'package:fr_lenra_client/app.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

// TODO generate this from annotation on LenraText
extension LenraTextExt on LenraText {
  static LenraText create({color, backgroundColor, value}) {
    return LenraText(color: color, backgroundColor: backgroundColor, value: value);
  }

  static const Map<String, String> propsTypes = {
    "value": "String",
    "color": "Color",
    "backgroundColor": "Color"
  };
}

class LenraText extends StatelessLenraComponent {
  final String value;
  final Color color;
  final Color backgroundColor;

  LenraText({this.color, this.backgroundColor, this.value}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      this.value,
      style: TextStyle(color: this.color, backgroundColor: this.backgroundColor),
    );
  }
}
