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
  }) : super(key: key);

  @override
  _LenraOverlayEntryState createState() => _LenraOverlayEntryState();
}

class _LenraOverlayEntryState extends State<LenraOverlayEntry> {
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    if (widget.showOverlay) {
      showOverlay();
    }
  }

  @override
  void didUpdateWidget(LenraOverlayEntry oldWidget) {
    if (oldWidget.showOverlay == false && widget.showOverlay == true) {
      showOverlay();
    } else if (oldWidget.showOverlay == true && widget.showOverlay == false) {
      removeOverlay();
    }
    super.didUpdateWidget(oldWidget);
  }

  void showOverlay() {
    overlayEntry = _createOverlayEntry();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Overlay.of(context)!.insert(overlayEntry);
    });
  }

  void removeOverlay() {
    overlayEntry.remove();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      maintainState: widget.maintainState ?? false,
      opaque: widget.opaque ?? false,
      builder: (context) => LenraTheme(
        themeData: LenraThemeData(),
        child: Material(
            color: Colors.transparent,
            child: widget.child ?? Container(),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
