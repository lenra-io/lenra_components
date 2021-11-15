import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraOverlayEntry extends StatefulWidget {
  final Widget? child;
  final bool? maintainState;
  final bool? opaque;

  LenraOverlayEntry({
    Key? key,
    this.child,
    this.maintainState,
    this.opaque,
  }) : super(key: UniqueKey());

  @override
  _LenraOverlayEntryState createState() => _LenraOverlayEntryState();
}

class _LenraOverlayEntryState extends State<LenraOverlayEntry> {
  late OverlayEntry overlayEntry;
  bool isEntryShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _toggleOverlayEntry());
  }

  void _toggleOverlayEntry() {
    if (!isEntryShown) {
      overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(overlayEntry);
      isEntryShown = true;
    } else {
      overlayEntry.remove();
      isEntryShown = false;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      maintainState: widget.maintainState ?? false,
      opaque: widget.opaque ?? false,
      builder: (context) => LenraTheme(
        themeData: LenraThemeData(),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _toggleOverlayEntry(),
          child: Material(
            color: Colors.transparent,
            child: widget.child ?? Container(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
