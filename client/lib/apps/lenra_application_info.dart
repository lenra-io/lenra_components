import 'package:flutter/material.dart';

class LenraApplicationInfo {
  LenraApplicationInfo(
      {@required this.name, @required this.icon, this.color = Colors.blue});

  final String name;
  final Color color;
  final IconData icon;
}
