import 'package:flutter/widgets.dart';

class LenraFlex extends StatelessWidget {
  /// The children of the `LenraFlex`.
  final List<Widget> children;

  /// The spacing between each element of the `LenraFlex`. The value is multiplied by the theme's `baseSize`.
  final double spacing;

  /// Whether the `LenraFlex` should fill its parent.
  final bool fillParent;

  /// The alignment of the children along the main axis (`direction`).
  final MainAxisAlignment mainAxisAlignment;

  /// The alignment of the children along the cross axis (opposite of `direction`).
  final CrossAxisAlignment crossAxisAlignment;

  /// Whether the `LenraFlex` should be scrollable when it overflows.
  final bool scroll;

  /// The padding around the `LenraFlex`.
  final EdgeInsets? padding;

  /// Defines in which order the children should be layed out horizontally.
  final TextDirection? horizontalDirection;

  /// Defines in which order the children should be layed out vertically.
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  /// The direction to use as the main axis for laying out the children.
  final Axis direction;

  const LenraFlex({
    Key? key,
    this.spacing = 0,
    this.fillParent = false,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.direction = Axis.horizontal,
    this.scroll = false,
    this.padding,
    this.horizontalDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget flex = _buildFlex(context);

    if (scroll) {
      return _buildScrollable(flex);
    } else {
      return flex;
    }
  }

  Widget _buildScrollable(Widget flex) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
            scrollDirection: direction,
            child: fillParent
                ? Container(
                    constraints: _getScrollableContainerConstraints(constraints),
                    child: flex,
                  )
                : flex);
      },
    );
  }

  BoxConstraints _getScrollableContainerConstraints(BoxConstraints constraints) {
    if (direction == Axis.vertical) return BoxConstraints(minHeight: constraints.maxHeight);

    return BoxConstraints(minWidth: constraints.maxWidth);
  }

  Widget _buildFlex(BuildContext context) {
    Widget flex = Flex(
      mainAxisSize: fillParent ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      direction: direction,
      children: _buildSpacedChildren(context),
      textBaseline: textBaseline ?? TextBaseline.alphabetic,
      textDirection: horizontalDirection,
      verticalDirection: verticalDirection,
    );

    if (padding != null) {
      flex = Padding(
        padding: padding!,
        child: flex,
      );
    }

    return flex;
  }

  List<Widget> _buildSpacedChildren(BuildContext context) {
    List<Widget> spacedChildren = [];

    if (_isSpaceEvenly()) {
      spacedChildren.add(_buildSizedBox(spacing));
    }

    if (_isSpaceAround()) {
      spacedChildren.add(_buildSizedBox(spacing / 2));
    }

    children.asMap().forEach(
      (key, value) {
        if (key != 0) {
          spacedChildren.add(_buildSizedBox(spacing));
        }
        spacedChildren.add(value);
      },
    );

    if (_isSpaceEvenly()) {
      spacedChildren.add(_buildSizedBox(spacing));
    }

    if (_isSpaceAround()) {
      spacedChildren.add(_buildSizedBox(spacing / 2));
    }
    return spacedChildren;
  }

  bool _isSpaceAround() {
    return mainAxisAlignment == MainAxisAlignment.spaceAround;
  }

  bool _isSpaceEvenly() {
    return mainAxisAlignment == MainAxisAlignment.spaceEvenly;
  }

  Widget _buildSizedBox(double space) {
    return SizedBox(
      width: direction == Axis.horizontal ? space : 0,
      height: direction == Axis.vertical ? space : 0,
    );
  }
}
