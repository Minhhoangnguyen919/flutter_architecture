import 'dart:ui';

import 'package:flutter/material.dart';

class HexColors {
  HexColors._();

  /// Hex color is white
  static final Color white = HexColor.fromHex("#FFFFFF");
  static final Color black = HexColor.fromHex("#000000");
  static final Color textFieldColor = HexColor.fromHex("#C8C8C8");
  static final Color grey = HexColor.fromHex("#808080");
  static final Color red = HexColor.fromHex("#FF0000");
  static final Color activeColor = HexColor.fromHex("#2F80ED");
  static final Color buttonLoginColor = HexColor.fromHex("#2A2C2D");
  static final Color greyTextField = HexColor.fromHex("#808080").withOpacity(0.5);
  static final Color colorButtonLogin = HexColor.fromHex("#f5f7fa");

  static final Color backgroundColor = HexColor.fromHex("#E5E5E5");

}

/// Construct a color from the lower 32 bits of an [int].
///
/// The bits are interpreted as follows:
///
/// * Bits 24-31 are the alpha value.
/// * Bits 16-23 are the red value.
/// * Bits 8-15 are the green value.
/// * Bits 0-7 are the blue value.
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc"
  /// with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign]
  /// is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
