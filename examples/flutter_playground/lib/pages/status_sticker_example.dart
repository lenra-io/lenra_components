import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_status_sticker.dart';
import 'package:lenra_components/lenra_components.dart';

class StatusStickerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LenraStatusSticker'),
      ),
      body: Center(
        child: LenraFlex(
          direction: Axis.vertical,
          spacing: 1,
          children: [
            LenraFlex(
              spacing: 1,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LenraStatusSticker(color: LenraColorThemeData.lenraFunGreenPulse),
                Text("OK"),
              ],
            ),
            LenraFlex(
              spacing: 1,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LenraStatusSticker(color: LenraColorThemeData.lenraFunYellowPulse),
                Text("In Progress"),
              ],
            ),
            LenraFlex(
              spacing: 1,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LenraStatusSticker(color: LenraColorThemeData.lenraFunRedPulse),
                Text("Error"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
