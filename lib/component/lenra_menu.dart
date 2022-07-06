import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class LenraMenu extends StatelessWidget {
  final List<Widget> items;

  LenraMenu({
    Key? key,
    required this.items,
  })  : assert(items.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData theme = LenraTheme.of(context);

    return Container(
      color: LenraColorThemeData.lenraBlack,
      padding: EdgeInsets.only(
        top: theme.baseSize,
        bottom: theme.baseSize,
      ),
      child: IntrinsicWidth(
        child: _buildItems(),
      ),
    );
  }

  Widget _buildItems() {
    return LenraFlex(
      fillParent: false,
      direction: Axis.vertical,
      children: items,
    );
  }
}

class LenraMenuItem extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isSelected;
  final bool disabled;
  final Widget? icon;

  const LenraMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.disabled = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget res = _buildLine(context);

    if (!disabled) {
      res = _addInteractivity(res);
    }
    return res;
  }

  Widget _buildLine(BuildContext context) {
    final LenraThemeData theme = LenraTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.baseSize,
        vertical: theme.baseSize / 2,
      ),
      child: LenraFlex(
        spacing: 1,
        crossAxisAlignment: CrossAxisAlignment.center,
        fillParent: true,
        children: [
          _buildIconSpace(theme),
          _buildText(theme),
        ],
      ),
    );
  }

  Widget _buildText(LenraThemeData theme) {
    final LenraMenuThemeData lenraMenuThemeData = theme.lenraMenuThemeData;

    return Flexible(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: disabled ? theme.lenraTextThemeData.disabledBodyText : lenraMenuThemeData.menuText,
        ),
      ),
    );
  }

  Widget _buildIconSpace(LenraThemeData theme) {
    return SizedBox(
      height: theme.baseSize * 2,
      width: theme.baseSize * 2,
      child: icon,
    );
  }

  Widget _addInteractivity(Widget child) {
    // According to Flutter documentation an InkWell must have a Material ancestor
    // See https://api.flutter.dev/flutter/material/InkWell-class.html
    return Material(
      color: isSelected ? LenraColorThemeData.lenraBlue : Colors.transparent,
      child: InkWell(
        child: child,
        hoverColor: isSelected ? LenraColorThemeData.lenraBlue : LenraColorThemeData.lenraBlueHover,
        onTap: () {
          onPressed!();
        },
      ),
    );
  }
}
