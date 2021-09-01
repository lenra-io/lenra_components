import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class FlexTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlexTestState();
  }
}

class _FlexTestState extends State<FlexTest> {
  var crossAxisAlignments = [
    CrossAxisAlignment.start,
    CrossAxisAlignment.center,
    CrossAxisAlignment.end,
    CrossAxisAlignment.stretch,
    CrossAxisAlignment.baseline
  ];

  var mainAxisAlignments = [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
    MainAxisAlignment.spaceAround,
    MainAxisAlignment.spaceBetween,
    MainAxisAlignment.spaceEvenly,
  ];

  bool vertical = false;
  bool fillParent = false;
  bool scrollable = false;
  double width = 250;
  double height = 75;
  double spacing = 1;

  @override
  Widget build(BuildContext context) {
    return LenraFlex(
      children: [
        buildProperties(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: buildTable(),
        )
      ],
      direction: Axis.vertical,
      scroll: true,
    );
  }

  Widget buildProperties() {
    return LenraFlex(
      fillParent: true,
      children: [
        Spacer(),
        LenraCheckbox(
          label: "Scrollable",
          value: this.scrollable,
          onChanged: (b) => setState(() {
            this.scrollable = !this.scrollable;
          }),
        ),
        LenraFlex(
          direction: Axis.vertical,
          children: [
            LenraCheckbox(
              label: "Vertical",
              value: this.vertical,
              onChanged: (b) => setState(() {
                this.vertical = !this.vertical;
              }),
            ),
            LenraCheckbox(
              label: "fillParent",
              value: this.fillParent,
              onChanged: (b) => setState(() {
                this.fillParent = !this.fillParent;
              }),
            ),
          ],
        ),
        LenraFlex(
          direction: Axis.vertical,
          children: [
            Text("Spacing (${spacing.toStringAsPrecision(3)} = ${(spacing * 8).round().toString()}px)"),
            Slider(
              value: spacing,
              min: 0.0,
              max: 10.0,
              label: spacing.round().toString(),
              onChanged: (double value) {
                setState(() {
                  spacing = value;
                });
              },
            ),
          ],
        ),
        LenraFlex(
          direction: Axis.vertical,
          children: [
            Text("Width (${width.round().toString()})"),
            Slider(
              value: width,
              min: 0.0,
              max: 500.0,
              onChanged: (double value) {
                setState(() {
                  width = value;
                });
              },
            ),
          ],
        ),
        LenraFlex(
          direction: Axis.vertical,
          children: [
            Text("Height (${height.round().toString()})"),
            Slider(
              value: height,
              min: 0.0,
              max: 500.0,
              label: height.round().toString(),
              onChanged: (double value) {
                setState(() {
                  height = value;
                });
              },
            ),
          ],
        ),
        Spacer(),
      ],
      direction: Axis.horizontal,
      spacing: 3,
    );
  }

  Widget buildTable() {
    return LenraFlex(
      direction: Axis.vertical,
      children: mainAxisAlignments
          .map((e) => buildFlexLine(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: e,
              ))
          .toList()
            ..insert(
              0,
              LenraFlex(
                direction: Axis.horizontal,
                children: crossAxisAlignments.map((e) => buildText(e.toString())).toList()..insert(0, buildText("-")),
              ),
            ),
    );
  }

  Widget buildFlexLine({
    required Axis direction,
    required MainAxisAlignment mainAxisAlignment,
  }) {
    List<Widget> children = crossAxisAlignments.map((e) {
      return buildFlex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: e,
      );
    }).toList()
      ..insert(0, buildText(mainAxisAlignment.toString()));
    return LenraFlex(
      direction: Axis.horizontal,
      children: children,
    );
  }

  Widget buildText(String text) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Text(text),
      ),
    );
  }

  Widget buildFlex(
      {required MainAxisAlignment mainAxisAlignment,
      required Axis direction,
      required CrossAxisAlignment crossAxisAlignment}) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        height: height,
        width: width,
        color: Colors.grey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.lightBlue,
            child: LenraFlex(
              scroll: scrollable,
              fillParent: fillParent,
              children: buildList(),
              direction: direction,
              spacing: spacing,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> list = [];
    list.add(Container(
      color: Colors.red,
      width: 10,
      height: 10,
      child: Center(
          child: Text(
        "1",
        style: TextStyle(fontSize: 8),
      )),
    ));
    list.add(Container(
      color: Colors.blue,
      width: 15,
      height: 15,
      child: Center(
          child: Text(
        "2",
        style: TextStyle(fontSize: 12),
      )),
    ));
    list.add(
      Container(
        color: Colors.green,
        width: 20,
        height: 20,
        child: Center(
            child: Text(
          "3",
          style: TextStyle(fontSize: 16),
        )),
      ),
    );
    list.add(Container(
      color: Colors.yellow,
      width: 30,
      height: 30,
      child: Center(
          child: Text(
        "4",
        style: TextStyle(fontSize: 20),
      )),
    ));
    list.add(Container(
      color: Colors.orange,
      width: 40,
      height: 40,
      child: Center(
          child: Text(
        "5",
        style: TextStyle(fontSize: 32),
      )),
    ));
    return list;
  }
}
