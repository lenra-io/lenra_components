import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

// ignore: must_be_immutable
class LenraOverlayEntry extends StatefulWidget {
  final Widget? child;
  final bool? maintainState;
  final bool? opaque;
  bool showOverlay;

  LenraOverlayEntry({
    Key? key,
    this.child,
    this.maintainState,
    this.opaque,
    this.showOverlay = false,
  }) : super(key: UniqueKey());

  @override
  _LenraOverlayEntryState createState() => _LenraOverlayEntryState();
}

class _LenraOverlayEntryState extends State<LenraOverlayEntry> {
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showOrHideOverlay());
  }

  void _showOrHideOverlay() {
    if (widget.showOverlay) {
      overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(overlayEntry);
    } else {
      overlayEntry.remove();
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
          onTap: () {
              widget.showOverlay = false;
            _showOrHideOverlay();
          },
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
