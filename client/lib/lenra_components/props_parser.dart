library props_parser;

import 'package:flutter/painting.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component_wrapper.dart';
import 'package:fr_lenra_client/utils/color_parser.dart';

extension ParserExt on Parser {
  // TODO : Generate this from annotation on class Parser
  static Map<String, Function> typeParsers = {
    "String": Parser.parseString,
    "bool": Parser.parseBool,
    "double": Parser.parseDouble,
    "Color": Parser.parseColor,
    "Map<String, dynamic>": Parser.parseListeners,
    "List<LenraComponentWrapper>": Parser.parseChildren
  };
}

class Parser {
  static Color parseColor(String color, LenraComponentWrapperState wrapperState) {
    return color.parseColor();
  }

  static String parseString(dynamic value, LenraComponentWrapperState wrapperState) {
    return value.toString();
  }

  static bool parseBool(dynamic value, LenraComponentWrapperState wrapperState) {
    if (value is bool) {
      return value;
    }
    return value.toString().toLowerCase() == "true";
  }

  static Map<String, dynamic> parseListeners(Map<String, dynamic> listeners, LenraComponentWrapperState wrapperState) {
    return listeners;
  }

  static double parseDouble(dynamic size, LenraComponentWrapperState wrapperState) {
    if (size is String) {
      return double.parse(size);
    } else if (size is double) {
      return size;
    }
    return 0;
  }

  static List<LenraComponentWrapper> parseChildren(List<dynamic> children, LenraComponentWrapperState wrapperState) {
    int i = 0;
    return children.map((dynamic child) {
      return LenraComponentWrapperState.createChild(
        i++,
        child as Map<String, dynamic>,
        wrapperState,
      );
    }).toList();
  }

  static Map<Symbol, dynamic> parseProps(
      Map<String, dynamic> props, Map<String, String> propsTypes, LenraComponentWrapperState parent) {
    Map<Symbol, dynamic> transformedProps = Map();

    props.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        String type = propsTypes[key];
        if (ParserExt.typeParsers.containsKey(type)) {
          transformedProps[Symbol(key)] = ParserExt.typeParsers[type](value, parent);
        }
      }
    });

    return transformedProps;
  }
}
