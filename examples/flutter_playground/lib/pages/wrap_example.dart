import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';

class WrapExample extends StatefulWidget {
  const WrapExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WrapExampleState();
  }
}

class _WrapExampleState extends State<WrapExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.lightBlue,
        child: LenraWrap(
          alignment: WrapAlignment.center,
          children: wrapChildrenWithContainers(
            [
              const LenraWrap(
                spacing: 15,
                children: [Text("Foo"), Text("Wrapped")],
              ),
              const LenraWrap(
                spacing: 15,
                runSpacing: 1,
                children: [Text("Foo"), Text("Wrapped")],
              ),
              const LenraWrap(
                direction: Axis.vertical,
                spacing: 15,
                children: [Text("Foo"), Text("Wrapped")],
              ),
              const LenraWrap(
                direction: Axis.vertical,
                spacing: 15,
                runSpacing: 1,
                children: [Text("Foo"), Text("Wrapped")],
              ),
              LenraWrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(height: 80, width: 80, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(height: 80, width: 80, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Container(height: 80, width: 80, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.center,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.end,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                alignment: WrapAlignment.start,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.center,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.end,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.spaceAround,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.spaceEvenly,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                spacing: 13,
                runAlignment: WrapAlignment.start,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                horizontalDirection: TextDirection.rtl,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                horizontalDirection: TextDirection.ltr,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                verticalDirection: VerticalDirection.up,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
              LenraWrap(
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(height: 20, width: 20, color: Colors.lightGreen),
                  Container(height: 20, width: 20, color: Colors.lime)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> wrapChildrenWithContainers(List<Widget> children) {
  return children
      .map((e) => Container(decoration: BoxDecoration(border: Border.all()), height: 120, width: 120, child: e))
      .toList();
}
