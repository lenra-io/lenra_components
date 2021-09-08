import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_components/theme/lenra_menu_theme_data.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';

class LenraMenu extends StatelessWidget {
  final List<LenraMenuItem> items;

  LenraMenu({
    Key? key,
    required this.items,
  })  : assert(items.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LenraThemeData theme = LenraTheme.of(context);

    return Container(
      color: LenraColorThemeData.LENRA_BLACK,
      padding: EdgeInsets.only(
        top: theme.baseSize,
        bottom: theme.baseSize,
      ),
      child: IntrinsicWidth(
        child: this._buildItems(),
      ),
    );
  }

  Widget _buildItems() {
    return LenraFlex(
      fillParent: false,
      direction: Axis.vertical,
      children: this.items,
    );
  }
}

class LenraMenuItem extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isSelected;
  final bool disabled;
  final Widget? icon;

  LenraMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.disabled = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget res = this._buildLine(context);

    if (!this.disabled) {
      res = this._addInteractivity(res);
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
          this._buildIconSpace(theme),
          this._buildText(theme),
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
          style: this.disabled ? theme.lenraTextThemeData.disabledBodyText : lenraMenuThemeData.menuText,
        ),
      ),
    );
  }

  Widget _buildIconSpace(LenraThemeData theme) {
    return Container(
      height: theme.baseSize * 2,
      width: theme.baseSize * 2,
      child: this.icon,
    );
  }

  Widget _addInteractivity(Widget child) {
    // According to Flutter documentation an InkWell must have a Material ancestor
    // See https://api.flutter.dev/flutter/material/InkWell-class.html
    return Material(
      color: this.isSelected ? LenraColorThemeData.LENRA_BLUE : Colors.transparent,
      child: InkWell(
        child: child,
        hoverColor: this.isSelected ? LenraColorThemeData.LENRA_BLUE : LenraColorThemeData.LENRA_BLUE_HOVER,
        onTap: () {
          onPressed!();
        },
      ),
    );
  }
}
