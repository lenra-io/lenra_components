import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import 'package:lenra_components/lenra_components.dart';

class MyLenraStyledContainer extends StatelessWidget {
  final List<bool> selectedItems = [false, false];

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      children: [
        LenraStyledContainer(
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            child: Text("test"),
          ),
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: BoxShadow(
            offset: const Offset(2.0, 2.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
