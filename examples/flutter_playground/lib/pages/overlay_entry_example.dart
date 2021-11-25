import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/layout/lenra_overlay_entry.dart';
import 'package:lenra_components/lenra_components.dart';

class OverlayEntryExample extends StatefulWidget {
  const OverlayEntryExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OverlayEntryExampleState();
  }
}

class _OverlayEntryExampleState extends State<OverlayEntryExample> {
  Widget test = const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LenraFlex(
        direction: Axis.horizontal,
        children: [
          LenraButton(
            text: "Show Overlay",
            onPressed: () {
              setState(() {
                test = LenraOverlayEntry(
                  child: LenraFlex(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: LenraButton(
                          text: "Foo",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
          test,
        ],
      ),
    );
  }
}
