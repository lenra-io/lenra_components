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

  final Axis direction;

  LenraFlex({
    Key? key,
    this.spacing: 0,
    this.fillParent: false,
    required this.children,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.crossAxisAlignment: CrossAxisAlignment.start,
    this.direction: Axis.horizontal,
    this.scroll: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Flex flex = _buildFlex(context);

    if (scroll) {
      return _buildScrollable(flex);
    } else {
      return flex;
    }
  }

  Widget _buildScrollable(Widget flex) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              scrollDirection: this.direction,
              child: this.fillParent
                  ? Container(
                      constraints: _getScrollableContainerConstraints(constraints),
                      child: flex,
                    )
                  : flex);
        },
      ),
    );
  }

  BoxConstraints _getScrollableContainerConstraints(BoxConstraints constraints) {
    if (this.direction == Axis.vertical) return BoxConstraints(minHeight: constraints.maxHeight);

    return BoxConstraints(minWidth: constraints.maxWidth);
  }

  Flex _buildFlex(BuildContext context) {
    return Flex(
      mainAxisSize: fillParent ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: this.crossAxisAlignment,
      direction: this.direction,
      children: _buildSpacedChildren(context),
      textBaseline: TextBaseline.alphabetic,
    );
  }

  List<Widget> _buildSpacedChildren(BuildContext context) {
    List<Widget> spacedChildren = [];
    var theme = LenraTheme.of(context);
    var space = this.spacing * theme.baseSize;

    if (this._isSpaceEvenly()) {
      spacedChildren.add(this._buildSizedBox(space));
    }

    if (this._isSpaceAround()) {
      spacedChildren.add(this._buildSizedBox(space / 2));
    }

    this.children.asMap().forEach(
      (key, value) {
        if (key != 0) {
          spacedChildren.add(this._buildSizedBox(space));
        }
        spacedChildren.add(value);
      },
    );

    if (this._isSpaceEvenly()) {
      spacedChildren.add(this._buildSizedBox(space));
    }

    if (this._isSpaceAround()) {
      spacedChildren.add(this._buildSizedBox(space / 2));
    }
    return spacedChildren;
  }

  bool _isSpaceAround() {
    return this.mainAxisAlignment == MainAxisAlignment.spaceAround;
  }

  bool _isSpaceEvenly() {
    return this.mainAxisAlignment == MainAxisAlignment.spaceEvenly;
  }

  Widget _buildSizedBox(double space) {
    return SizedBox(
      width: this.direction == Axis.horizontal ? space : 0,
      height: this.direction == Axis.vertical ? space : 0,
    );
  }
}
