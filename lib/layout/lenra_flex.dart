import 'package:flutter/cupertino.dart';
import 'package:lenra_components/theme/lenra_theme.dart';

class LenraFlex extends StatelessWidget {
  final List<Widget> children;
  //Multiplaying factor of the theme BaseSize (8)
  final double spacing;
  final bool fillParent;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool scroll;
  final EdgeInsets? padding;

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
      textBaseline: TextBaseline.alphabetic,
    );

    if (padding != null) {
      flex = Padding(
        padding: padding! * LenraTheme.of(context).baseSize,
        child: flex,
      );
    }

    return flex;
  }

  List<Widget> _buildSpacedChildren(BuildContext context) {
    List<Widget> spacedChildren = [];
    var theme = LenraTheme.of(context);
    var space = spacing * theme.baseSize;

    if (_isSpaceEvenly()) {
      spacedChildren.add(_buildSizedBox(space));
    }

    if (_isSpaceAround()) {
      spacedChildren.add(_buildSizedBox(space / 2));
    }

    children.asMap().forEach(
      (key, value) {
        if (key != 0) {
          spacedChildren.add(_buildSizedBox(space));
        }
        spacedChildren.add(value);
      },
    );

    if (_isSpaceEvenly()) {
      spacedChildren.add(_buildSizedBox(space));
    }

    if (_isSpaceAround()) {
      spacedChildren.add(_buildSizedBox(space / 2));
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
