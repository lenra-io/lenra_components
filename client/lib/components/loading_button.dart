import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool loading;

  LoadingButton({this.onPressed, this.child, this.loading = false});

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
      return CircularProgressIndicator();
    }

    return ElevatedButton(
      onPressed: this.onPressed,
      child: this.child,
    );
  }
}
