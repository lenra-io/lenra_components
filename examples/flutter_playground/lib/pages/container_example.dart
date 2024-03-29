import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import 'package:lenra_components/lenra_components.dart';

class ContainerExample extends StatelessWidget {
  final List<bool> selectedItems = [false, false];

  ContainerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      fillParent: true,
      spacing: 2,
      children: [
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraContainer(
              decoration: const BoxDecoration(
                color: Colors.purple,
              ),
              child: square("Purple"),
            ),
            LenraContainer(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: square("Green"),
            ),
            LenraContainer(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              child: square("Orange"),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraContainer(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                border: Border.all(width: 1),
              ),
              child: square("Border 1px"),
            ),
            LenraContainer(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                border: Border.all(width: 3, color: Colors.lightBlue),
              ),
              child: square("Border color"),
            ),
            LenraContainer(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                border: Border.all(width: 3, color: Colors.lightBlue),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: square("BorderRadius"),
            ),
          ],
        ),
        LenraFlex(
          fillParent: true,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            LenraContainer(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(2, 2),
                      blurRadius: 2)
                ],
              ),
              child: square("Shadow"),
            ),
            LenraContainer(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                      color: Colors.purple.withOpacity(0.4),
                      offset: const Offset(3, 3),
                      blurRadius: 2)
                ],
              ),
              child: square("Shadow color"),
            ),
            LenraContainer(
              decoration: BoxDecoration(
                color: Colors.cyan,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.elliptical(10, 20),
                  topLeft: Radius.elliptical(10, 20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5, 2),
                    blurRadius: 3,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: square("All in one"),
            ),
          ],
        ),
        const LenraContainer(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: EdgeInsets.all(30),
          child: Text("Padding"),
        ),
      ],
    );
  }

  Widget square(String text) {
    return LenraContainer(
      constraints: BoxConstraints(
        maxHeight: 100,
        minHeight: 100,
        maxWidth: 100,
        minWidth: 100,
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}
