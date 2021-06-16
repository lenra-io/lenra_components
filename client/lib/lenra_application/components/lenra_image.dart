import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraImage> {
  LenraImage map({value, backgroundColor, height, width}) {
    return LenraImage(value: value, backgroundColor: backgroundColor, width: width, height: height);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "backgroundColor": "Color",
      "width": "double",
      "height": "double",
    };
  }
}

class LenraImage extends StatelessLenraComponent {
  final String value;
  final Color? backgroundColor;
  final double? height;
  final double? width;

  LenraImage({
    required this.value,
    required this.backgroundColor,
    required this.height,
    required this.width,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Uint8List _bytes = base64.decode(this.value.split(',').last);

    return Image.memory(_bytes, color: this.backgroundColor, width: this.width, height: this.height);
  }
}
