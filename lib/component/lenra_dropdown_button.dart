import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraDropdownButton extends StatefulWidget {
  final String text;
  final LenraMenu menu;
  final bool disabled;
  final LenraComponentSize size;
  final LenraComponentType type;
  final Widget? icon;

  LenraDropdownButton({
    required this.text,
    required this.menu,
    this.disabled = false,
    this.size = LenraComponentSize.Medium,
    this.type = LenraComponentType.Primary,
    this.icon = const Icon(Icons.expand_more_outlined),
    Key? key,
  }) : super(key: key);

  @override
  _LenraDropdownButtonState createState() => _LenraDropdownButtonState();
}

class _LenraDropdownButtonState extends State<LenraDropdownButton> {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool showOverlay = false;

  toggleOverlay(BuildContext context) async {
    if (showOverlay) {
      this._overlayEntry.remove();
      showOverlay = !showOverlay;
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context)!.insert(this._overlayEntry);
      showOverlay = !showOverlay;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => toggleOverlay(context),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _Dropdown(
            renderBox: renderBox,
            menu: widget.menu,
            layerLink: _layerLink,
          ),
        ),
      ),
    );

    this._overlayEntry = overlayEntry;
    return this._overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: LenraButton(
        text: widget.text,
        onPressed: () {
          toggleOverlay(context);
        },
        disabled: widget.disabled,
        size: widget.size,
        type: widget.type,
        rightIcon: widget.icon,
      ),
    );
  }
}

class _Dropdown extends StatefulWidget {
  final LenraMenu menu;
  final LayerLink layerLink;
  final RenderBox renderBox;

  _Dropdown({
    required this.menu,
    required this.layerLink,
    required this.renderBox,
    Key? key,
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<_Dropdown> {
  GlobalKey overlayKey = GlobalKey();
  Offset? overlayOffset;
  bool verticalScroll = false;
  bool horizontalScroll = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (overlayOffset == null) {
        var temp = overlayKey.currentContext?.findRenderObject();

        if (temp != null) {
          var tempOffset = (temp as RenderBox).localToGlobal(Offset.zero);
          var overlaySize = temp.size;
          var buttonSize = widget.renderBox.size;
          var buttonOffset = widget.renderBox.localToGlobal(Offset.zero);
          var screenSize = MediaQuery.of(context).size;

          bool overflowRight = tempOffset.dx + overlaySize.width > screenSize.width;
          bool overflowLeft = buttonOffset.dx + buttonSize.width - overlaySize.width < 0;
          bool overflowBottom = buttonOffset.dy + buttonSize.height + overlaySize.height > screenSize.height;
          bool overflowTop = buttonOffset.dy - overlaySize.height < 0;

          setState(() {
            var xOffset = 0.0; // Default x Offset, top left of overlay is just under bottom left of button
            var yOffset = buttonSize.height; // Default y Offset, overlay is just under button

            if (overflowRight && overflowLeft) {
              // Add horizontal scroll
              horizontalScroll = true;
            }

            if (overflowBottom && overflowTop) {
              // Add vertical scroll
              verticalScroll = true;
            } else if (overflowBottom) {
              yOffset = -overlaySize.height;
            }

            if (overflowRight) {
              xOffset = -(overlaySize.width - buttonSize.width);
            }

            overlayOffset = Offset(xOffset, yOffset);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //var offset = widget.renderBox.localToGlobal(Offset.zero);

    Widget child = Material(
      key: overlayKey,
      child: widget.menu,
      color: Colors.transparent,
    );

    if (verticalScroll) {
      child = Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      );
      // ScrollView should replace CompositedTransformFollower, it should also define a container to resize the LenraMenu
      // See IOS Pickers https://developer.apple.com/design/human-interface-guidelines/ios/controls/pickers/

      // For two-sided scroll, define a SingleChildScrollView horizontally with a ListView inside
    } else {
      child = CompositedTransformFollower(
        offset: overlayOffset ?? Offset(0, widget.renderBox.size.height),
        //offset: Offset(0, widget.renderBox.size.height),
        link: widget.layerLink,
        child: child,
      );
    }

    return Stack(
      children: [
        child,
      ],
    );
  }
}
