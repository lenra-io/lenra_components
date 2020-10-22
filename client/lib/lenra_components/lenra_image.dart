import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

class LenraImageState extends LenraComponentState {
  LenraImageState(
      {String id,
      LenraComponentState parent,
      Map<String, dynamic> properties,
      Map<String, dynamic> styles,
      Stream stream})
      : super(
            id: id,
            parent: parent,
            properties: properties,
            styles: styles,
            stream: stream);

  @override
  Widget build(BuildContext context) {
    // TODO: Change color from Hex to Int representation of color
    Uint8List _bytes = base64.decode(this.properties['value'].split(',').last);
    String hex;
    if (this.properties['backgroundColor'] != null) {
      hex = this.properties['backgroundColor'].replaceFirst('#', '');
    }
    Color backgroundColor =
        hex != null ? Color(int.parse('FF$hex', radix: 16)) : null;
    return Container(
        child: Image.memory(_bytes),
        color: backgroundColor,
        width: this.properties['width'],
        height: this.properties['height']);
  }
}
