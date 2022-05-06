import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
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
  bool removeOverlays = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LenraFlex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 2,
        children: [
          LenraText(text: "You can show another overlay by clicking on the button below."),
          LenraFlex(
            spacing: 2,
            children: [
              LenraButton(
                text: "Show",
                onPressed: () {
                  setState(() {
                    showOverlay = true;
                    removeOverlays = false;
                  });
                },
              ),
              LenraButton(
                text: "Remove overlays",
                onPressed: () {
                  setState(() {
                    removeOverlays = true;
                  });
                },
              ),
            ],
          ),
          if (!removeOverlays) ...[
            LenraOverlayEntry(
              showOverlay: showOverlay,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Container(
                  child: Center(
                    child: Container(
                      color: LenraColorThemeData.greyNature,
                      child: LenraFlex(
                        direction: Axis.vertical,
                        padding: EdgeInsets.all(2),
                        spacing: 2,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LenraText(text: "This is an overlay entry"),
                          LenraButton(
                            text: "Close",
                            onPressed: () {
                              setState(() {
                                showOverlay = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            LenraOverlayEntry(
              showOverlay: showOverlay2,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Container(
                  color: LenraColorThemeData.greyLight,
                  child: Center(
                    child: LenraFlex(
                      spacing: 2,
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LenraText(text: "This is an overlay."),
                        LenraText(text: "You can close it by clicking on the button."),
                        LenraButton(
                          text: "Close",
                          onPressed: () {
                            setState(() {
                              showOverlay2 = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
