import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';

class LoadingButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool loading;
  final Widget rightIcon;

  LoadingButton({this.onPressed, this.text, this.rightIcon, this.loading = false});

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
      return CircularProgressIndicator();
    }

    return LenraButton(
      onPressed: !this.loading ? this.onPressed : null,
      text: this.text,
      rightIcon: this.loading ? CircularProgressIndicator() : this.rightIcon,
    );
  }
}
