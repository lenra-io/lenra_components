import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/actionable/events/lenra_on_edit_event.dart';
import 'package:fr_lenra_client/lenra_components/actionable/lenra_actionable.dart';
import 'package:fr_lenra_client/lenra_components/lenra_component.dart';

class LenraTextfieldState extends LenraComponentState
    implements LenraActionable {
  LenraTextfieldState(
      {String id,
      LenraComponentState parent,
      Map<String, dynamic> properties,
      Map<String, dynamic> styles})
      : super(id: id, parent: parent, properties: properties, styles: styles);

  FocusNode _focusNode;
  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    String _value = this.properties['value'];
    this._controller = TextEditingController(text: this.properties['value']);
    this._focusNode = FocusNode();

    //? When we leave the cursor from the textfield
    // TODO: emit the event when you didn't press anything in 3 seconds. (Why not use flutter delayed)
    this._focusNode.addListener(() {
      // check if the text was changed
      if (_value != _controller.text) {
        _value = _controller.text;
        if (this.properties['listeners'] != null) {
          final Map<String, dynamic> listener =
              this.properties['listeners']['onChange'];
          LenraOnEditEvent(
              code: listener['code'],
              event: {'value': _controller.text}).dispatch(context);
        }
      }
    });

    return TextField(
      //? This is to create icon before the textfield.
      // decoration: this.properties['obscureText'] ?? false
      //     ? InputDecoration(
      //         labelText: this.properties['label'],
      //         icon: const Padding(
      //           padding: const EdgeInsets.only(top: 15.0),
      //           child: const Icon(Icons.lock),
      //         ),
      //       )
      //     : InputDecoration(labelText: this.properties['label']),
      //? Add a label before the textfield
      decoration: InputDecoration(labelText: this.properties['label']),
      //? _controller allow to read the value of the textfield.
      controller: this._controller,
      //? _controller allow to detect the focus on the textfield
      focusNode: this._focusNode,
      //? If this is a password field, transform any char in the textfield by the `*` character
      obscureText: this.properties['obscureText'] ?? false,
      //? After any keypress
      onChanged: (value) {
        this.properties['value'] = _controller.text;
      },
      //? When we press enter on the textfield.
      onEditingComplete: () {
        if (_value != _controller.text) {
          _value = _controller.text;
          if (this.properties['listeners'] != null) {
            final Map<String, dynamic> listener =
                this.properties['listeners']['onChange'];
            if (listener != null) {
              LenraOnEditEvent(
                  code: listener['code'],
                  event: {'value': _controller.text}).dispatch(context);
            }
          }
        }
      },
    );
  }
}
