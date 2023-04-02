import 'package:flutter/material.dart';

abstract class AppColors {
  static final Color primaryDefault = HexColor.fromHex('#28FF00');
  static final Color primaryDark = HexColor.fromHex('#0C4D00');
  static final Color primaryDark10 = HexColor.fromHex('#144018');
  static final Color primaryLight = HexColor.fromHex('#D4FFCC');

  static final Color black = HexColor.fromHex('#121212');
  static final Color white = HexColor.fromHex('#FFFFFF');

  static final Color alertWarning = HexColor.fromHex('#EA5A0C');
  static final Color alertSuccess = HexColor.fromHex('#7FC613');
  static final Color alertCritical = HexColor.fromHex('#FC3A40');
  static final Color alertInfo = HexColor.fromHex('#166FE2');

  static final Color greyLight = HexColor.fromHex('#FAFAFA');
  static final Color greyLight10 = HexColor.fromHex('#F9F9F9');
  static final Color greyLight20 = HexColor.fromHex('##F2F2F7');
  static final Color greyLight30 = HexColor.fromHex('#DBDFE7');
  static final Color greyLight40 = HexColor.fromHex('#F8F8F8');

  static final Color greyDark = HexColor.fromHex('#CCCCCC');
  static final Color greyDark10 = HexColor.fromHex('#AEAEAE');
  static final Color greyDark20 = HexColor.fromHex('#8E8E93');
  static final Color greyDark30 = HexColor.fromHex('#555555');

  static const Color green = Color(0xFFD5FBCE);
  static final Color greenLight = HexColor.fromHex('#D5FBCE');
  static final Color greenDark = HexColor.fromHex('#305C34');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    var tmpHexColorString = hexColorString.replaceAll('#', '');
    if (tmpHexColorString.length == 6) {
      tmpHexColorString = '0xFF$tmpHexColorString';
    } else {
      tmpHexColorString = '0x$tmpHexColorString';
    }
    return Color(int.parse(tmpHexColorString));
  }
}
