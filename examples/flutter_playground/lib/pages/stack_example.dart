import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_stack.dart';

class StackExample extends StatefulWidget {
  const StackExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StackExampleState();
  }
}

class _StackExampleState extends State<StackExample> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: wrapChildrenWithContainers(
        [
          LenraStack(children: createCircles()),
          LenraStack(
            alignment: AlignmentDirectional.bottomCenter,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.bottomEnd,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.bottomStart,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.center,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.centerEnd,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.centerStart,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.topCenter,
            children: createCircles(),
          ),
          LenraStack(
            alignment: AlignmentDirectional.topEnd,
            children: createCircles(),
          ),
          LenraStack(
            fit: StackFit.expand,
            children: createCircles(),
          ),
          LenraStack(
            fit: StackFit.passthrough,
            children: createCircles(),
          ),
        ],
      ),
    );
  }
}

List<Widget> wrapChildrenWithContainers(List<Widget> children) {
  return children
      .map((e) => Container(decoration: BoxDecoration(border: Border.all()), height: 120, width: 120, child: e))
      .toList();
}

List<Widget> createCircles() {
  return [
    Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    ),
    Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightBlue,
      ),
    )
  ];
}
