import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

class LenraTextState extends LenraComponentState {
  LenraTextState({
    String id,
    LenraComponentState parent,
    Map<String, dynamic> properties,
    Map<String, dynamic> styles,
  }) : super(id: id, parent: parent, properties: properties, styles: styles);

  @override
  Widget build(BuildContext context) {
    // TODO: Change color from Hex to Int representation of color

    String hex;
    if (this.properties['color'] != null) {
      hex = this.properties['color'].replaceFirst('#', '');
    }
    Color color = hex != null ? Color(int.parse('FF$hex', radix: 16)) : null;

    // TODO: Change color from Hex to Int representation of color
    hex = null;
    if (this.properties['backgroundColor'] != null) {
      hex = this.properties['backgroundColor'].replaceFirst('#', '');
    }
    Color backgroundColor =
        hex != null ? Color(int.parse('FF$hex', radix: 16)) : null;

    return Text(
      this.properties['value'].toString(),
      style: TextStyle(color: color, backgroundColor: backgroundColor),
    );
  }
}
