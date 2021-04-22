import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';

void main() {
  test('lenra button test parameterized constructor', () {
    LenraButton lenraButton = LenraButton(
      disabled: true,
      text: "disabled",
      size: LenraButtonSize.Large,
      type: LenraButtonType.Secondary,
      leftIcon: null,
      rightIcon: null,
    );

    expect(lenraButton.disabled, true);
    expect(lenraButton.text, "disabled");
    expect(lenraButton.size, LenraButtonSize.Large);
    expect(lenraButton.type, LenraButtonType.Secondary);
    expect(lenraButton.leftIcon, null);
    expect(lenraButton.rightIcon, null);
  });
}
