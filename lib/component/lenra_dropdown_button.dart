import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

/// A dropdown button showing a dropdown when clicked.
///
/// When using a [LenraMenu] as a child, 
/// the menu will be by default non-interactive which means that when clicking a menu item, 
/// the state of the menu will not be updated unless it is closed and reopened.
/// 
/// To make the menu interactive, containing it inside a StatefulWidget is required as per the example below.
/// This example is an interactive menu where its items are removed when clicked.
/// 
/// ```dart
/// class Menu extends StatefulWidget {
///   final List<bool> items;
///
///   final List<int> selectedItems;
///
///   const Menu({Key? key, required this.items, required this.selectedItems}) : super(key: key);
///
///   @override
///   State<StatefulWidget> createState() {
///     return MenuState();
///   }
/// }
///
/// class MenuState extends State<Menu> {
///   @override
///   Widget build(BuildContext context) {
///     return LenraMenu(
///       items: widget.items
///           .asMap()
///           .entries
///           .where((e) => !widget.selectedItems.contains(e.key))
///           .map((e) => LenraMenuItem(
///                  text: "test ${e.key}",
///                  isSelected: e.value,
///                  onPressed: () => {
///                    setState(() {
///                      widget.selectedItems.add(e.key);
///                   })
///                  },
///               ))
///            .toList(),
///      );
///   }
/// }
///
/// ```
class LenraDropdownButton extends StatefulWidget {
  final String text;
  final Widget child;
  final bool disabled;
  final LenraComponentSize size;
  final LenraComponentType type;
  final Widget? icon;

  LenraDropdownButton({
    required this.text,
    required this.child,
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
  // [_layerLink] is used to make sure the child of [LenraDropdownButton] is correctly following the [LenraDropdownButton] when scrolling.
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
            child: widget.child,
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
  final Widget child;
  final LayerLink layerLink;
  final RenderBox renderBox;

  _Dropdown({
    required this.child,
    required this.layerLink,
    required this.renderBox,
    Key? key,
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<_Dropdown> with TickerProviderStateMixin {
  // TickerProviderStateMixin is used to correctly execute the fade animation of the menu
  GlobalKey overlayKey = GlobalKey();
  Offset? overlayOffset;
  bool verticalScroll = false;
  bool horizontalScroll = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (overlayOffset == null) {
        var overlay = overlayKey.currentContext?.findRenderObject();

        if (overlay != null) {
          var overlaySize = (overlay as RenderBox).size;
          var buttonSize = widget.renderBox.size;
          var buttonOffset = widget.renderBox.localToGlobal(Offset.zero);
          var screenSize = MediaQuery.of(context).size;

          bool overflowRight = buttonOffset.dx + overlaySize.width >= screenSize.width;
          bool overflowLeft = buttonOffset.dx + buttonSize.width - overlaySize.width <= 0;
          bool overflowBottom = buttonOffset.dy + buttonSize.height + overlaySize.height >= screenSize.height;
          bool overflowTop = buttonOffset.dy - overlaySize.height <= 0;

          setState(() {
            _controller.forward();
            var xOffset = 0.0; // Default x Offset, top left of overlay is just under bottom left of button
            var yOffset = buttonSize.height; // Default y Offset, overlay is just under button

            if (overflowRight && overflowLeft) {
              // Add horizontal scroll
              horizontalScroll = true;
            } else if (overflowRight) {
              xOffset = -(overlaySize.width - buttonSize.width);
            }

            if (overflowBottom && overflowTop) {
              // Add vertical scroll
              verticalScroll = true;
            } else if (overflowBottom) {
              yOffset = -overlaySize.height;
            }

            overlayOffset = Offset(xOffset, yOffset);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Material(
      key: overlayKey,
      child: widget.child,
      color: Colors.transparent,
    );

    // Handles vertical and horizontal scrolling
    if (verticalScroll || horizontalScroll) {
      if (horizontalScroll) {
        child = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        );
      }

      if (verticalScroll) {
        child = SingleChildScrollView(
          child: child,
        );
      }

      child = Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: child,
          ),
        ),
      );
    } else {
      child = CompositedTransformFollower(
        offset: overlayOffset ?? Offset(0, widget.renderBox.size.height),
        link: widget.layerLink,
        child: child,
      );
    }

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
      child: Stack(
        children: [
          child,
        ],
      ),
    );
  }
}
