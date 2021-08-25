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
  //TODO (Lenra-300): Add padding

  final Axis direction;

  LenraFlex({
    Key? key,
    this.spacing = 0,
    this.fillParent: false,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.direction,
    this.scroll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> colChildren = children;
    if (spacing > 0) {
      var theme = LenraTheme.of(context);
      colChildren = [];
      var space = spacing * theme.baseSize;
      if (this.mainAxisAlignment == MainAxisAlignment.spaceAround ||
          this.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
        colChildren.addAll([
          SizedBox(
            width: 0,
            height: 0,
          ),
          SizedBox(
            width: this.direction == Axis.horizontal ? space : 0,
            height: this.direction == Axis.vertical ? space : 0,
          ),
        ]);
      }
      children.asMap().forEach(
        (key, value) {
          if (key > 0) {
            if (this.mainAxisAlignment == MainAxisAlignment.spaceAround) {
              colChildren.addAll([
                SizedBox(
                  width: this.direction == Axis.horizontal ? space : 0,
                  height: this.direction == Axis.vertical ? space : 0,
                ),
                SizedBox(
                  width: 0,
                  height: 0,
                ),
              ]);
            }
            colChildren.add(SizedBox(
              width: this.direction == Axis.horizontal ? space : 0,
              height: this.direction == Axis.vertical ? space : 0,
            ));
          }

          colChildren.add(value);
        },
      );
      if (this.mainAxisAlignment == MainAxisAlignment.spaceAround ||
          this.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
        colChildren.addAll([
          SizedBox(
            width: 0,
            height: 0,
          ),
          SizedBox(
            width: this.direction == Axis.horizontal ? space : 0,
            height: this.direction == Axis.vertical ? space : 0,
          ),
        ]);
      }
    }

    Flex flex = Flex(
      mainAxisSize: fillParent ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: (this.mainAxisAlignment == MainAxisAlignment.spaceAround ||
              this.mainAxisAlignment == MainAxisAlignment.spaceEvenly)
          ? MainAxisAlignment.spaceBetween
          : this.mainAxisAlignment,
      crossAxisAlignment: this.crossAxisAlignment,
      direction: this.direction,
      children: colChildren,
    );

    if (scroll) {
      return Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                scrollDirection: this.direction,
                child: this.fillParent
                    ? Container(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: flex,
                      )
                    : flex);
          },
        ),
      );
    } else {
      return flex;
    }
  }
}
