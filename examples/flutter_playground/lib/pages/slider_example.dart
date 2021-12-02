import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SliderExampleState();
  }
}

class _SliderExampleState extends State<SliderExample> {
  var value = 0.5;
  String label = "Hello World!";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LenraFlex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
        children: [
          LenraSlider(
            divisions: 4,
            value: value,
            onChanged: (v) {
              setState(() {
                value = v;
                label = v.toString();
              });
            },
            onChangeStart: (v) {
              setState(() {
                label = "Start $v";
              });
            },
            onChangeEnd: (v) {
              setState(() {
                label = "End $v";
              });
            },
          ),
          LenraText(text: label),
        ],
      ),
    );
  }
}
