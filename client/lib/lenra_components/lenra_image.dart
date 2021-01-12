import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

// TODO : generate this from annotation on LenraImage
extension LenraImageExt on LenraImage {
  static LenraImage create({value, backgroundColor, height, width}) {
    return LenraImage(value: value, backgroundColor: backgroundColor, width: width, height: height);
  }

  static const Map<String, String> propsTypes = {
    "value": "String",
    "backgroundColor": "Color",
    "width": "double",
    "height": "double",
  };
}

class LenraImage extends StatelessLenraComponent {
  final String value;
  final Color backgroundColor;
  final double height;
  final double width;

  LenraImage({this.value, this.backgroundColor, this.height, this.width}) : super();

  @override
  Widget build(BuildContext context) {
    Uint8List _bytes = base64.decode(this.value.split(',').last);

    return Image.memory(_bytes,
        color: this.backgroundColor, width: this.width, height: this.height);
  }
}
