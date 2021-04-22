import 'package:flutter/material.dart';

abstract class LenraStatefulComponent extends StatefulWidget {
  static Function update;
  final GlobalKey key = null;
}
