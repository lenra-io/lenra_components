import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_edit_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

// TODO : generate this from annotation on LenraTextfield
extension LenraTextfieldExt on LenraTextfield {
  static LenraTextfield create({value, listeners}) {
    return LenraTextfield(
      value: value,
      listeners: listeners,
    );
  }

  static const Map<String, String> propsTypes = {"value": "String", "listeners": "Map<String, dynamic>"};
}

// ignore: must_be_immutable
class LenraTextfield extends StatelessLenraComponent implements LenraActionable {
  String value;
  final Map<String, dynamic> listeners;
  final FocusNode _focusNode;
  final TextEditingController _controller;

  LenraTextfield({String value, this.listeners})
      : this._controller = TextEditingController(text: value),
        this._focusNode = FocusNode(),
        super();

  @override
  Widget build(BuildContext context) {
    this._focusNode.addListener(() {
      // check if the text was changed
      if (this.value != _controller.text) {
        this.value = _controller.text;
        if (this.listeners != null) {
          final Map<String, dynamic> listener = this.listeners['onChange'];
          LenraOnEditEvent(code: listener['code'], event: {'value': _controller.text}).dispatch(context);
        }
      }
    });

    return TextField(
      // _controller allow to read the value of the textfield.
      controller: this._controller,
      // _controller allow to detect the focus on the textfield
      focusNode: this._focusNode,
      // After any keypress
      // onChanged: (value) {
      //   this.value = _controller.text;
      // },
      // When we press enter on the textfield.
      onEditingComplete: () {
        if (this.value != _controller.text) {
          this.value = _controller.text;
          if (this.listeners != null) {
            final Map<String, dynamic> listener = this.listeners['onChange'];
            if (listener != null) {
              LenraOnEditEvent(code: listener['code'], event: {'value': _controller.text}).dispatch(context);
            }
          }
        }
      },
    );
  }
}
