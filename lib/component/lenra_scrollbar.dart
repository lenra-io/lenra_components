//import 'package:flutter/material.dart';
//
//class LenraScrollBar extends StatelessWidget {
//  final Axis direction;
//  final List<Widget> children;
//  final ScrollController? controller;
//  final EdgeInsetsGeometry? padding;
//
//  LenraScrollBar({
//    required this.direction,
//    required this.children,
//    this.controller,
//    this.padding,
//    Key? key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    if (this.children.length > 1) {
//      //ListView.builder for large list
//      return ListView(
//        scrollDirection: this.direction,
//        controller: (this.controller != null) ? this.controller : ScrollController(),
//        children: this.children,
//        padding: (this.padding != null) ? this.padding : EdgeInsets.all(0),
//      );
//    } else {
//      return SingleChildScrollView(
//        scrollDirection: this.direction,
//        controller: (this.controller != null) ? this.controller : ScrollController(),
//        child: this.children.first,
//        padding: (this.padding != null) ? this.padding : EdgeInsets.all(0),
//      );
//    }
//  }
//}
