import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_container.dart';
import 'package:fr_lenra_client/lenra_components/lenra_radio.dart';

class LenraRadioContainer extends LenraContainer {
  final List<LenraRadio> children;
  final Function onChanged;
  final GlobalKey<_LenraRadioContainer> key = new GlobalKey<_LenraRadioContainer>();

  LenraRadioContainer({
    this.children,
    this.onChanged,
  });

  @override
  _LenraRadioContainer createState() {
    return _LenraRadioContainer(
      children: this.children,
    );
  }
}

class _LenraRadioContainer extends State<LenraRadioContainer> {
  final List<LenraRadio> children;
  final Function onChanged;

  _LenraRadioContainer({
    this.children,
    this.onChanged,
  });

  int _selected;

  @override
  void initState() {
    super.initState();
    LenraRadio.update = update;
    LenraRadio.getChanged = getValue;
    LenraRadio.onChanged = onValueChanged;
  }

  void update() {
    children.forEach((element) {
      element.key.currentState.setState(() {});
    });
  }

  void onValueChanged(value) {
    _selected = value;
    if (onChanged != null) onChanged();
  }

  int getValue() {
    return _selected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: this.children);
  }
}
