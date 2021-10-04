import 'package:flutter/painting.dart';

extension ColorParser on String {
  /// Parses a [Color] from this [String].
  Color parseColor() {
    final buffer = StringBuffer();
    // Adds 100% (ff) opacity if hex string looks like this "aabbcc" or this "#aabbcc"
    if (length == 6 || length == 7) buffer.write('ff');
    // Removes the leading "#"
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
