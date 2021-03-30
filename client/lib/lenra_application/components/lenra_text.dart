import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';

// TODO generate this from annotation on LenraText
class LenraTextBuilder extends LenraComponentBuilder<LenraText> {
  LenraText map({color, backgroundColor, value}) {
    return LenraText(color: color, backgroundColor: backgroundColor, value: value);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "color": "Color",
      "backgroundColor": "Color",
    };
  }
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
