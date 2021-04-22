import 'package:fr_lenra_client/lenra_components/theme/lenra_text_theme_data.dart';

class LenraCheckboxThemeData {
  LenraTextThemeData lenraTextThemeData;

  LenraCheckboxThemeData({
    LenraTextThemeData lenraTextThemeData,
  }) {
    this.lenraTextThemeData = lenraTextThemeData ?? LenraTextThemeData();
  }

  LenraCheckboxThemeData merge(LenraCheckboxThemeData incoming) {
    if (incoming != null) {
      return LenraCheckboxThemeData(
        lenraTextThemeData: this.lenraTextThemeData.merge(incoming.lenraTextThemeData),
      );
    }

    return this;
  }
}
