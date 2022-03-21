import 'package:flutter/material.dart';
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
  bool showOverlay = false;
  bool showOverlay2 = true;
  bool showOverlay3 = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LenraFlex(
        direction: Axis.horizontal,
        children: [
          LenraButton(
            text: "Show Overlay",
            onPressed: () {
              print("Show Overlay");
              setState(() {
                showOverlay = true;
              });
            },
          ),
          LenraOverlayEntry(
            showOverlay: showOverlay,
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
          ),
          LenraOverlayEntry(
            showOverlay: showOverlay3,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: LenraButton(
                      text: "Foo3",
                      onPressed: () {
                        setState(() {
                          showOverlay3 = false;
                        });
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
