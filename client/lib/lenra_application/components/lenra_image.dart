import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_image.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraApplicationImage> {
  LenraApplicationImage map({path, backgroundColor, height, width}) {
    return LenraApplicationImage(path: path, width: width, height: height);
  }

  Map<String, String> get propsTypes {
    return {
      "path": "String",
      "width": "double",
      "height": "double",
    };
  }
}

class LenraApplicationImage extends StatelessLenraComponent {
  final String path;
  // TODO: For future features add handling for image resizing
  final double? height;
  final double? width;

  LenraApplicationImage({
    required this.path,
    required this.height,
    required this.width,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraImage(path: path);
  }
}
