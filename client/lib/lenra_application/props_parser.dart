library props_parser;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fr_lenra_client/utils/color_parser.dart';

extension ParserExt on Parser {
  // TODO : Generate this from annotation on class Parser
  static Map<String, Function> typeParsers = {
    "String": Parser.parseString,
    "bool": Parser.parseBool,
    "double": Parser.parseDouble,
    "Color": Parser.parseColor,
    "Map<String, dynamic>": Parser.parseListeners,
  };
}

class Parser {
  static Color parseColor(String color) {
    return color.parseColor();
  }

  static String parseString(dynamic value) {
    return value.toString();
  }

  static bool parseBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    return value.toString().toLowerCase() == "true";
  }

  static Map<String, dynamic> parseListeners(Map<String, dynamic> listeners) {
    return listeners;
  }

  static double parseDouble(dynamic size) {
    if (size is String) {
      return double.parse(size);
    } else if (size is double) {
      return size;
    }
    return 0;
  }

  static Map<Symbol, dynamic> parseProps(Map<String, dynamic> props, Map<String, String> propsTypes) {
    Map<Symbol, dynamic> transformedProps = Map();

    props.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        String type = propsTypes[key]!;
        if (ParserExt.typeParsers.containsKey(type)) {
          transformedProps[Symbol(key)] = ParserExt.typeParsers[type]!(value);
        }
      }
    });

    return transformedProps;
  }
}
