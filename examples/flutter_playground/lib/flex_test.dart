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
  bool takeAllWidth = false;
  double width = 250;
  double height = 200;
  double spacing = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: LenraFlex(
        children: [
          buildProperties(),
          buildTable(),
        ],
        direction: Axis.vertical,
      ),
    );
  }

  Widget buildProperties() {
    return LenraFlex(
      children: [
        Spacer(),
        LenraFlex(
          children: [
            LenraCheckbox(
              label: "Vertical",
              value: this.vertical,
              onChanged: (b) => setState(() {
                this.vertical = !this.vertical;
              }),
            ),
            LenraCheckbox(
              label: "Take All width",
              value: this.takeAllWidth,
              onChanged: (b) => setState(() {
                this.takeAllWidth = !this.takeAllWidth;
              }),
            ),
          ],
          direction: Axis.vertical,
        ),
        Text("Spacing"),
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
        Text("Width"),
        Slider(
          value: width,
          min: 0.0,
          max: 500.0,
          label: width.round().toString(),
          onChanged: (double value) {
            setState(() {
              width = value;
            });
          },
        ),
        Text("Height"),
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
        Spacer(),
      ],
      direction: Axis.horizontal,
      spacing: 3,
    );
  }

  Table buildTable() {
    var columnWidth =
        takeAllWidth ? FlexColumnWidth() : FixedColumnWidth(width);
    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: columnWidth,
        1: columnWidth,
        2: columnWidth,
        3: columnWidth,
        4: columnWidth,
        5: columnWidth,
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: mainAxisAlignments
          .map((e) => buildFlexLine(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: e,
              ))
          .toList()
            ..insert(
              0,
              TableRow(
                children:
                    crossAxisAlignments.map((e) => Text(e.toString())).toList()
                      ..insert(0, Text("-")),
              ),
            ),
    );
  }

  TableRow buildFlexLine({
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
      ..insert(0, Text(mainAxisAlignment.toString()));
    return TableRow(
      children: children,
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
        child: LenraFlex(
          children: buildList(),
          direction: direction,
          spacing: spacing,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        ),
        color: Colors.grey,
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
